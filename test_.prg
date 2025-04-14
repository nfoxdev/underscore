
Public omypc && check later in your debugger

oMypc = Createobject('empty')

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
      .power = .newList('CPU','CASE1','CASE2','CASE3')  

		* create a collection, then add items to it:
		.SPECS = .newCollection()

		* add items to collection , with key "memory" and "usb":
		with .newItemFor('specs','memory')
			.type = 'DDR4'
			.MAXSIZE = '64GB'
			.slots = 4
		endwith
		
		with .newItemFor('specs','usb')
			.internal = '3 @ PCIe 3.0 x2'
			.front = 'x1 Type-C'
			.rear  = 'x2 Type-A'
		endwith

	Endwith

	* create an empty list , then add items to it:

	.storage = .newList()
	
	with .newItemFor( 'storage' )  && adding objects to list
		.manufacturer = 'Samsung'
		.model = '960 evo Series'
		.Type = 'internal'
		.connectivity = 'PCIe NVMe M.2'
		.capacity = '250gb'
	Endwith

	with .newItemFor( 'storage' )
		.manufacturer = 'Seagate'
		.model = 'Barracuda ST3000DM008'
		.Type = 'Internal'
		.formfactor = 3.5
		.capacity = '3tb'
		.connectivity = 'Sata 6.0'
		.rotationspeed = 7200
	Endwith


endwith

clear

? 'oMypc.motherboard.power[1]: ',oMypc.motherboard.power[1]
? 'oMypc.storage[1].model: ',oMypc.storage[1].model
? 'oMypc.storage[2].model: ',oMypc.storage[2].model
? 'oMypc.motherboard.specs("memory").slots: ',omypc.motherboard.specs('memory').slots
? 'oMypc.motherboard.specs("usb").front: ',omypc.motherboard.specs('usb').front


