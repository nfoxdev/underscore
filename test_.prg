
Public omypc && check later on your debugger

oMypc = Createobject('empty')

* add properties to oMypc:

With _( m.omypc )  

	.manufacturer = 'custom'
	.baseprice = 699
	.casetype  = 'ATX'
	.modelname = 'Ryzen Performance Plus'

	With _( .cpu )   && a new object for oMyPc -  we pass ".cpu"  ( dot cpu )
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

		* create a list ( one-column array ) with 4 items:
		.power = .newList('CPU','CASE1','CASE2','CASE3')  

		* create a collection:
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

	* add a list of objects:

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

? oMypc.motherboard.power[1]
? oMypc.storage[1].connectivity
? omypc.motherboard.specs('memory').maxsize
? omypc.motherboard.specs('memory').slots
? omypc.motherboard.specs('usb').front


