package repos.mysql

import creacionales.POIBuilder
import creacionales.ServicioBuilder
import creacionales.UsuarioBuilder
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Banco
import poi.CGP
import poi.Colectivo
import poi.Local
import poi.Rubro
import poi.Usuario
import repos.mysql.RepoUsuario

class TestRepoUsuario {
	RepoUsuario repoUsuario
	Usuario usuario
	
	Colectivo linea2
	Colectivo linea7
	Local trigoDeOro
	Rubro rubroPanaderia
	Banco nacionSanMartin
	CGP cgp11
	
	@Before
	def void init()
	{
		repoUsuario = RepoUsuario.instance

		usuario = new UsuarioBuilder()
			.nombre ("Javier")
			.contrasenia("123")
			.ubicacion(11, 133).ubicacion(22, 19).ubicacion(33, 10).ubicacion(92, 11)
			.build
		
		linea2 = new POIBuilder()
			.colectivo
			.numero(2)
			.domicilio("Alvear 2340")
			.parada(1, 13).parada(2, 1).parada(3, 1).parada(41, 18)
			.build
			
		linea7 = new POIBuilder()
			.colectivo
			.numero(2).domicilio("Perez Acuña 4987")
			.parada(1, 18).parada(2, 81).parada(3, 1).parada(4, 1).parada(45, 121).parada(4, 11)
			.build
		
		trigoDeOro = new POIBuilder()
			.local
			.nombre("Trigo de Oro")
			.rubro(rubroPanaderia)
			.clave("pan")
			.clave("facturas")
			.domicilio("Alcorta 3798")
			.ubicacion(11, 7)
			.horario(#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0)
			.build
		
		nacionSanMartin = new POIBuilder()
			.banco
			.compania("Nacion")
			.barrio("San Martin")
			.domicilio("Mitre 3920").
			servicio("Depositos").servicio("Extracciones").servicio("Plazo Fijo")
			.ubicacion(4, 1).build
			
			val dni = new ServicioBuilder().nombre("DNI").horario("Lunes", 10, 0, 18, 0).horario("Martes", 10, 0, 15, 0).
			horario("Miercoles", 10, 0, 15, 0).horario("Jueves", 10, 0, 15, 0).horario("Viernes", 10, 0, 18, 0).build

			val cuit_cuil = new ServicioBuilder().nombre("Cuit/Cuil").horario("Lunes", 10, 0, 18, 0).horario("Martes", 10,
			0, 15, 0).horario("Viernes", 10, 0, 18, 0).build
			
			
		cgp11 = new POIBuilder()
			.cgp
			.comuna(11).ubicacion(11, 11).servicio(dni).servicio(cuit_cuil).domicilio(
			"Ayacucho 2742").limite(7, 11).limite(11, 7).limite(11, 13).build
			
			
		}
		

	@Test
	def void PoiEnFavorito(){
		repoUsuario.saveOrUpdate(usuario)
		
		var javi = repoUsuario.searchById(usuario.id)
		
		Assert.assertEquals(0, javi.listaFavoritos.size)
	
		javi.addFavorito(cgp11)
		
		repoUsuario.saveOrUpdate(javi)
		
		javi = repoUsuario.searchById(usuario.id)
		
		Assert.assertEquals(1, javi.listaFavoritos.size)
		
		repoUsuario.DeleteById(javi.id)
	}
	
	@Test
	def void muchosPoiEnFavorito(){
		repoUsuario.saveOrUpdate(usuario)
	
		var javi = repoUsuario.searchById(usuario.id) 
		
		Assert.assertEquals(0, javi.listaFavoritos.size)
		
		javi.addFavorito(linea2)
		javi.addFavorito(linea7)
		javi.addFavorito(trigoDeOro)
		javi.addFavorito(nacionSanMartin)
		javi.addFavorito(cgp11)
		
		repoUsuario.saveOrUpdate(javi)
		
		javi = repoUsuario.searchById(usuario.id)
		
		Assert.assertEquals(5, javi.listaFavoritos.size)
		
		repoUsuario.DeleteById(javi.id)
		
	}
}
