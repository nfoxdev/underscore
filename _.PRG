**************************************************************
* underscore v 1.0.2
* Marco Plaza, nfoxdev 2018,2025
* https://github.com/nfoxdev/underscore
*************************************************************
*
* usage: 
*
*
* with _( object , [ cNewPropertyName ] )
*
*   .property1 = any valid vfp expression
*
*   .property2 = any valid vfp expression
*
*   with _( .<newObjectPropertyName> [,cNewpropertyName] )
*
*   endwith
*
*    .myCollection = .newCollection( [Item1,Item2,... Item20 ])
*
*    .myList = .newList( [ Item1,Item2,... Item20 ] )
*
*    .additems( "< collection/array name >" , item1,item2,.. item20 )
*
*    with .newItemFor("< collection/array name >" [, collectionItemkey] )
*
*      .itemproperty1 = value
*
*      .itemproperty2 = value
*
*    endwith
*
* endwith
*
*
**************************************************************

Lparameters __otarget__, newpropname


Local result,tact,oerror


Try

  Do Case

  Case Vartype(__otarget__) # 'O'
    Error ' Invalid parameter type - must supply an object '

  Case Pcount() = 2 And Vartype(m.newpropname ) = 'C'

    tact = Type( '__oTarget__.'+newpropname )

    Do Case
    Case m.tact = 'U'
      AddProperty( m.__otarget__ , m.newpropname, Createobject('empty') )
    Case m.tact # 'O'
      __otarget__.&newpropname = Createobject('empty')
    Endcase

    result = Createobject('nfset',__otarget__.&newpropname)

  Otherwise

    result = Createobject('nfset',m.__otarget__)

  Endcase

Catch To oerror
  result = .Null.

Endtry

If Vartype(m.oerror) = 'O'
  Error oerror.Message 
Endif


Return m.result



******************************************
Define Class nfset As Custom
******************************************
  __otarget__ = .F.
  __lastproperty__ = ''
  __passitems__ = .F.

*----------------------------------------
  Protected Procedure Init( __otarget__ )
*----------------------------------------
    This.__otarget__ = m.__otarget__
    AddProperty(This,'__atemp__(1)')

*------------------------------------------------------
  Protected Procedure this_access( pname As String )
*------------------------------------------------------

    This.__copytemp__()

    If Lower(m.pname)+',' $  '__apush__,__otarget__,__lastproperty__,newitemfor,newlist,newcollection,additems,__atemp__,__passitems__,__copytemp__,'
      Return This
    Endif

    This.__lastproperty__ = m.pname

    If !Pemstatus(This.__otarget__,m.pname,5)
      AddProperty(This.__otarget__,m.pname, Createobject('empty') )
    Endif

    Return This.__otarget__

*----------------------------------------------------------------------------------------------------
  Function additems( pname, p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20 )
*----------------------------------------------------------------------------------------------------

  Local ot,isarray,nn

  If Not Type( 'this.__oTarget__.'+m.pname,1) $ 'C,A'
    Error  pname + ' is not a Collection / Array '
  Endif

  isarray = Type( 'this.__oTarget__.'+m.pname,1) = 'A'

  ot = This.__otarget__

  For nn = 1 To Pcount()-1

    If m.isarray
      This.__apush__( m.ot,m.pname, Evaluate('m.p'+Transform(m.nn,'@b 99')))
    Else
      m.ot.&pname..Add( Evaluate('m.p'+Transform(m.nn,'@b 99')) )
    Endif

  Endfor


*---------------------------------------
  Function newitemfor( pname, Key )
*---------------------------------------


  Local ot,tvar,onew

  If Type('pName') # 'C'
    Error ' newItemFor() invalid parameter Type '
  Endif

  ot = This.__otarget__

  tvar = Type( 'oT.'+m.pname , 1 )

  Do Case

  Case m.tvar = 'C'

    onew = Create('empty')

    If Pcount() = 2
      m.ot.&pname..Add( m.onew, m.key  )
    Else
      m.ot.&pname..Add( m.onew )
    Endif

    Return Createobject('nfset',m.onew )

  Case m.tvar = 'A'

    onew = Create('empty')

    This.__apush__( m.ot,m.pname, m.onew )

    Return Createobject('nfset',m.onew)

  Otherwise


    Error m.pname + ' is not a Collection / Array '

  Endcase


*---------------------------------------------------------------------------------------------
  Procedure newlist( p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20 )
*---------------------------------------------------------------------------------------------

  Local np

  With This

    Removeproperty(.__otarget__,.__lastproperty__)
    AddProperty(.__otarget__,.__lastproperty__+'(1)')

    If Pcount() > 0
      Dimension .__atemp__( Pcount() )
      For np = 1 To Pcount()
        .__atemp__(m.np) =  Evaluate('m.p'+Transform(m.np,'@b 99'))
      Endfor
      .__passitems__ = .T.
    Else
      Dimension .__atemp__(1)
      .__atemp__(1) = .Null.
      .__passitems__ = .F.
    Endif

  Endwith

  Return .Null.

*-------------------------------
  Procedure Destroy
*-------------------------------
  This.__copytemp__()


*----------------------------------------
  Protected Procedure __copytemp__
*----------------------------------------
    Local aname

    With This

      If !.__passitems__
        Return
      Endif

      aname = .__lastproperty__
      Acopy( .__atemp__,.__otarget__.&aname )

      .__atemp__     = .Null.
      .__passitems__ = .F.

    Endwith

*---------------------------------------------------------------------------------------------------
  Procedure newcollection(  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20 )
*---------------------------------------------------------------------------------------------------

  Local ocol,nn

  ocol = Createobject('collection')

  For nn = 1 To Pcount()

    ocol.Add(  Evaluate('m.p'+Transform(m.nn,'@b 99') ))

  Endfor

  Return m.ocol


*-----------------------------------------
  Function __apush__( o, pname , vvalue )
*-----------------------------------------
  Local uel

  uel = Alen( m.o.&pname )

  If !Isnull( m.o.&pname )
    m.uel = m.uel+1
    Dimension m.o.&pname( m.uel )
  Endif

  m.o.&pname( m.uel ) =  m.vvalue



**********************************************
Enddefine
**********************************************

*-----------------------------------------
Procedure testme
*-----------------------------------------

Public omypc && check later in your debugger

omypc = Createobject('empty')

* add properties to oMypc:

With _( m.omypc )

  .manufacturer = 'custom'
  .baseprice = 699
  .casetype  = 'ATX'
  .modelname = 'Ryzen Performance Plus'

  With _( .cpu )   && a cpu for oMyPc passing "dot cpu"
    .processorcount = 6
    .brand = 'AMD'
    .model = 'Ryzen 7'
    .clockspeed = 4.3
    .processorcount = 8
  Endwith

  With _(.motherboard)

    .manufacturer = 'Asus'
    .model = 'Prime B350-Plus AMD'
    .formfactor = 'ATX'
    .cpusocket = 'AM4'

* create a quick list ( one-column array ) with 4 items:
    .Power = .newlist('CPU','CASE1','CASE2','CASE3')

* create a collection, then add items to it:
    .specs = .newcollection()

* add items to collection , with key "memory" and "usb":
    With .newitemfor('specs','memory')
      .Type = 'DDR4'
      .maxsize = '64GB'
      .slots = 4
    Endwith

    With .newitemfor('specs','usb')
      .internal = '3 @ PCIe 3.0 x2'
      .front = 'x1 Type-C'
      .rear  = 'x2 Type-A'
    Endwith

  Endwith

* create an empty list , then add items to it:

  .storage = .newlist()

  With .newitemfor( 'storage' )  && adding objects to list
    .manufacturer = 'Samsung'
    .model = '960 evo Series'
    .Type = 'internal'
    .connectivity = 'PCIe NVMe M.2'
    .capacity = '250gb'
  Endwith

  With .newitemfor( 'storage' )
    .manufacturer = 'Seagate'
    .model = 'Barracuda ST3000DM008'
    .Type = 'Internal'
    .formfactor = 3.5
    .capacity = '3tb'
    .connectivity = 'Sata 6.0'
    .rotationspeed = 7200
  Endwith


Endwith

Clear

? 'oMypc.motherboard.power[1]: ',omypc.motherboard.Power[1]
? 'oMypc.storage[1].model: ',omypc.storage[1].model
? 'oMypc.storage[2].model: ',omypc.storage[2].model
? 'oMypc.motherboard.specs("memory").slots: ',omypc.motherboard.specs('memory').slots
? 'oMypc.motherboard.specs("usb").front: ',omypc.motherboard.specs('usb').front



