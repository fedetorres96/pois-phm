package repos

import creacionales.POIBuilder
import creacionales.ServicioBuilder
import poi.POI
import poi.Rubro

class RepoPOI extends RepoGeneral<POI> {

	static RepoPOI instance

	static def RepoPOI getInstance() {
		instance ?: new RepoPOI
	}

	private new() {
	}

	override getEntityType() {
		typeof(POI)
	}

	def searchByQuery(String query) {
		allInstances.filter[coincideBusqueda(query) && habilitado].toList
	}

	def void cargaInicial() {
		val rentas = new ServicioBuilder().nombre("Rentas").horario("Lunes", 10, 0, 13, 0).horario("Miercoles", 10, 0,
			13, 0).horario("Sabado", 10, 0, 13, 0).build

		val bici = new ServicioBuilder().nombre("Eco Bici").horario("Lunes", 10, 0, 15, 0).horario("Martes", 10, 0, 15,
			0).horario("Sabado", 10, 0, 18, 0).build

		val dni = new ServicioBuilder().nombre("DNI").horario("Lunes", 10, 0, 18, 0).horario("Martes", 10, 0, 15, 0).
			horario("Miercoles", 10, 0, 15, 0).horario("Jueves", 10, 0, 15, 0).horario("Viernes", 10, 0, 18, 0).build

		val cuit_cuil = new ServicioBuilder().nombre("Cuit/Cuil").horario("Lunes", 10, 0, 18, 0).horario("Martes", 10,
			0, 15, 0).horario("Viernes", 10, 0, 18, 0).build

		val rubroFruteria = new Rubro => [nombre = "Fruteria" radio = 5]
		val rubroPanaderia = new Rubro => [nombre = "Panaderia" radio = 3]
		val rubroCarpinteria = new Rubro => [nombre = "Panaderia" radio = 3]

		val cgp11 = new POIBuilder().cgp.comuna(11).ubicacion(11, 11).servicio(dni).servicio(cuit_cuil).domicilio(
			"Ayacucho 2742").limite(7, 11).limite(11, 7).limite(11, 13).build

		val cgp15 = new POIBuilder().cgp.comuna(15).ubicacion(2, 2).servicio(rentas).servicio(bici).domicilio(
			"Av. Cordoba 5690").limite(0, 2).limite(2, 0).limite(4, 2).build

		val linea343 = new POIBuilder().colectivo.numero(343).domicilio("Gdor. Ugarte 4071").parada(1, 1).parada(2, 1).
			build

		val linea237 = new POIBuilder().colectivo.numero(237).domicilio("Av. Marquez 2711").parada(11, 11).parada(11,
			10).parada(11, 9).parada(7, 9).parada(7, 57).parada(7, 1).build

		val linea11 = new POIBuilder().colectivo.numero(11).domicilio("Av. Roldon 2265").parada(11, 11).parada(11, 5).
			parada(11, 9).parada(7, 9).parada(7, 7).parada(7, 15).build

		val linea27 = new POIBuilder().colectivo.numero(27).domicilio("Av. Parana 1121").parada(1, 11).parada(12, 210).
			parada(11, 9).parada(7, 9).parada(7, 7).parada(75, 1).build

		val linea78 = new POIBuilder().colectivo.numero(78).domicilio("Chacafa 7894").parada(11, 1).parada(11, 100).
			parada(11, 9).parada(7, 5).parada(7, 78).parada(7, 15).build

		val linea21 = new POIBuilder().colectivo.numero(21).domicilio("Alvarez 652").parada(11, 1).parada(1, 1).
			parada(11, 29).parada(77, 9).parada(7, 7).parada(7, 1).build

		val linea99 = new POIBuilder().colectivo.numero(99).domicilio("Av. Zufriategui 5852").parada(11, 5).parada(16,
			10).parada(2, 9).parada(7, 9).parada(7, 7).parada(7, 1).build

		val maninHnos = new POIBuilder().local.nombre("Manin Hnos.").rubro(rubroFruteria).clave("fruta").domicilio(
			"Moreno 3146").ubicacion(3, 1).horario(#["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"], 10, 0, 19,
			0).horario("Sabado", 10, 0, 13, 0).build

		val trigoDeOro = new POIBuilder().local.nombre("Trigo de Oro").rubro(rubroPanaderia).clave("pan").clave(
			"facturas").domicilio("Alcorta 3798").ubicacion(11, 7).horario(
			#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0).build

		val donRamon = new POIBuilder().local.nombre("Don Ramon").rubro(rubroPanaderia).clave("pan").clave("facturas").
			domicilio("Valencia 11256").ubicacion(11, 7).horario(
				#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0).build

		val loDePepe = new POIBuilder().local.nombre("Lo de Pepe").rubro(rubroCarpinteria).clave("madera").clave(
			"tornillos").domicilio("La Rioja 7745").ubicacion(53, 7).horario(
			#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0).build

		val nacionSanMartin = new POIBuilder().banco.compania("Nacion").barrio("San Martin").domicilio("Mitre 3920").
			servicio("Depositos").servicio("Extracciones").servicio("Plazo Fijo").ubicacion(4, 1).build

		val credicoopVillaLynch = new POIBuilder().banco.compania("Credicoop").barrio("Villa Lynch").domicilio(
			"Profesor M. Ashkar 1103").servicio("Depositos").servicio("Extracciones").servicio("Prestamos").servicio(
			"Banca Empresaria").servicio("Plazo Fijo").ubicacion(2, 3).build

		val provincia = new POIBuilder().banco.compania("Provincia").barrio("Villa Ballester").domicilio("Combet 7189").
			servicio("Depositos").servicio("Extracciones").servicio("Prestamos").servicio("Banca Empresaria").servicio(
				"Plazo Fijo").ubicacion(5, 1).build

		val galicia = new POIBuilder().banco.compania("Galicia").barrio("San Andres").domicilio("Piedriel 8952").
			servicio("Depositos").servicio("Extracciones").servicio("Prestamos").servicio("Banca Empresaria").servicio(
				"Plazo Fijo").ubicacion(1, 9).build

		val santanderRio = new POIBuilder().banco.compania("Santander Rio").barrio("Villa Libertad").domicilio(
			"Lamadrid 335").servicio("Depositos").servicio("Extracciones").servicio("Prestamos").servicio(
			"Banca Empresaria").servicio("Plazo Fijo").ubicacion(7, 8).build

		saveOrUpdate(cgp11)
		saveOrUpdate(cgp15)
		saveOrUpdate(linea343)
		saveOrUpdate(linea237)
		saveOrUpdate(linea11)
		saveOrUpdate(linea27)
		saveOrUpdate(linea78)
		saveOrUpdate(linea21)
		saveOrUpdate(linea99)
		saveOrUpdate(maninHnos)
		saveOrUpdate(trigoDeOro)
		saveOrUpdate(donRamon)
		saveOrUpdate(loDePepe)
		saveOrUpdate(nacionSanMartin)
		saveOrUpdate(credicoopVillaLynch)
		saveOrUpdate(provincia)
		saveOrUpdate(galicia)
		saveOrUpdate(santanderRio)
	}
}
