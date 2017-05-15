package repos.mysql

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Local
import poi.Opinion
import poi.Usuario

class TestRepoOpinion {
	RepoOpinionMySQL opiniones
	RepoUsuario usuarios
	RepoPOI pois
	
	Opinion opinionFede;
	Opinion opinionMauro;
	
	Local mockLocal;
	
	Usuario fede
	Usuario mauro

	@Before
	def void init() {
		opiniones = RepoOpinionMySQL.instance
		usuarios = RepoUsuario.instance
		pois = RepoPOI.instance

		mockLocal = new Local

		pois.save(mockLocal)
		
		fede = new Usuario => [
			nombre = "Fede"
		]
		
		mauro = new Usuario => [
			nombre = "Mauro"
		]
		
		usuarios.save(fede)
		usuarios.save(mauro)

		opinionFede = new Opinion() => [
			calificacion = 3
			comentario = "Este Local es un Mock"
			poi = mockLocal
			usuario = fede
		]

		opinionMauro = new Opinion() => [
			calificacion = 5
			comentario = "Este Mock es una fiesta"
			poi = mockLocal
			usuario = mauro
		]
	}
	
	@After
	def void clean() {
		pois.delete(mockLocal)
		usuarios.delete(mauro)
		usuarios.delete(fede)
	}

	@Test
	def void altaDeUnaOpinion() {
		val nroOpinionesAntes = opiniones.allInstances.size

		opiniones.save(opinionFede)

		val nroOpinionesDespues = opiniones.allInstances.size

		Assert.assertEquals(nroOpinionesAntes + 1, nroOpinionesDespues)
		
		opiniones.delete(opinionFede)
	}

	@Test
	def void bajaDeUnaOpinion() {
		opiniones.save(opinionFede)

		val nroOpinionesAntes = opiniones.allInstances.size

		opiniones.delete(opinionFede)
				
		val nroOpinionesDespues = opiniones.allInstances.size

		Assert.assertEquals(nroOpinionesAntes - 1, nroOpinionesDespues)
	}
}
