package repos.mongodb

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Local
import poi.Opinion

import static org.mockito.Mockito.*

class TestRepoOpinion {
	RepoOpinion opiniones
	Opinion opinionFede;
	Opinion opinionMauro;
	Local mockLocal;

	@Before
	def void init() {
		opiniones = RepoOpinion.instance

		mockLocal = mock(Local)
		when(mockLocal.nombre).thenReturn("Mock Shop")
		when(mockLocal.calificacion).thenCallRealMethod
		when(mockLocal.listaOpiniones).thenCallRealMethod

		opinionFede = new Opinion() => [
			calificacion = 3
			comentario = "Este Local es un Mock"
			usuario = "Fede"
			poi = "Mock Shop"
		]

		opinionMauro = new Opinion() => [
			calificacion = 5
			comentario = "Este Mock es una fiesta"
			usuario = "Mauro"
			poi = "Mock Shop"
		]

	}

	@Test
	def void seAgreganOpinionesAlRepoOpinion() {
		val nroOpiniones = opiniones.allInstances.size

		opiniones.save(opinionFede)

		val nroOpinionesAfter = opiniones.allInstances.size

		Assert.assertEquals(nroOpiniones + 1, nroOpinionesAfter)

		opiniones.delete(opinionFede)
	}

	@Test
	def void seCalculaLaCalificacionPromedioCorrectamente() {
		opiniones.save(opinionFede)
		opiniones.save(opinionMauro)

		val calificacion = mockLocal.calificacion

		Assert.assertEquals(4, calificacion, 0)

		opiniones.delete(opinionFede)
		opiniones.delete(opinionMauro)
	}

}
