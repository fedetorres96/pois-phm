import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Local
import poi.Opinion
import repos.mongodb.RepoOpinion
import repos.mysql.RepoPOI

class TestRepoOpinion {
	RepoOpinion opiniones
	RepoPOI pois
	Opinion opinionFede;
	Opinion opinionMauro;
	Local mockLocal;

	@Before
	def void init() {
		opiniones = RepoOpinion.instance
		pois = RepoPOI.instance

		mockLocal = new Local => [
			nombre = "Mock Shop"
			descripcion = ""
		]

		pois.save(mockLocal)

		opinionFede = new Opinion() => [
			calificacion = 3
			comentario = "Este Local es un Mock"
			poi = mockLocal
		]

		opinionMauro = new Opinion() => [
			calificacion = 5
			comentario = "Este Mock es una fiesta"
			poi = mockLocal
		]

	}

	@Test
	def void seAgreganOpinionesAlRepoOpinion() {
		val nroOpinionesAntes = opiniones.allInstances.size

		opiniones.save(opinionFede)

		val nroOpinionesDespues = opiniones.allInstances.size

		Assert.assertEquals(nroOpinionesAntes + 1, nroOpinionesDespues)
	}

	@Test
	def void seCalculaLaCalificacionPromedioCorrectamente() {
		opiniones.save(opinionFede)

		val nroOpinionesAntes = opiniones.allInstances.size

		opiniones.delete(opinionFede)
				
		val nroOpinionesDespues = opiniones.allInstances.size

		Assert.assertEquals(nroOpinionesAntes - 1, nroOpinionesDespues)
	}

	@After
	def void clean() {
		pois.delete(mockLocal)

		opiniones.delete(opinionFede)
		opiniones.delete(opinionMauro)

	}
}
