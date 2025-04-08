  
# "underscore" \_()

Create complex Visual Foxpro Objects  adding properties, arrays and collections the easy way.

Just make \_.prg available in your search path and start using it. 

see test_.prg for usage and quick start.

Usage:

	with _( object [, cNewPropertyName ] ) 

  		.property1 = any valid vfp expression

		.property2 = any valid vfp expression
	
		with _( .<newObjectPropertyName> [,cNewpropertyName] )

  			.property = any valid vfp expression
	
		endwith

		 .myCollection = .newCollection( [Item1,Item2,... Item20 ]) 
	
		 .myList = .newList( [ Item1,Item2,... Item20 ] )
	
		 .additems( "< collection/array name >" , item1,item2,.. item20 )
	
		 with .newItemFor("< collection/array name >" [, collectionItemkey] )
	
			.itemproperty1 = value
	
			.itemproperty2 = value 
	
		 endwith

 	endwith

2025, Marco Plaza  
[GitHub/nfoxdev](https://github.com/nfoxdev)
