package repos.mysql

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Local
import poi.Opinion
import poi.Usuario

class TestCalificacion {
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

		opiniones.save(opinionFede)
		opiniones.save(opinionMauro)
	}

	@After
	def void clean() {
		opiniones.delete(opinionFede)
		opiniones.delete(opinionMauro)
		pois.delete(mockLocal)
		usuarios.delete(mauro)
		usuarios.delete(fede)
	}

	@Test
	def void seObtienenOpinionesDeUnPoi() {

		Assert.assertEquals(2, mockLocal.listaOpiniones.size)

	}

	@Test
	def void seObtieneCalificacionPromedioDeUnPoi() {

		Assert.assertEquals(4, mockLocal.calificacion, 0)

	}
}
