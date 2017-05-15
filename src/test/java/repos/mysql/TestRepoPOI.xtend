package repos.mysql

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Local

class TestRepoPOI {
	RepoPOI pois

	Local mockLocal

	@Before
	def void init() {
		pois = RepoPOI.instance

		mockLocal = new Local => [
			nombre = "Mock Shop"
			descripcion = ""
			habilitado = true

		]
	}

	@After
	def void clean() {
		val poiDB = pois.getById(mockLocal.id)
		
		
		if (poiDB != null) {
			pois.delete(mockLocal)
		}
	}

	@Test
	def void altaDeUnPoi() {
		val nroPoisAntes = pois.allInstances.size

		pois.save(mockLocal)

		val nroPoisDespues = pois.allInstances.size

		Assert.assertEquals(nroPoisAntes + 1, nroPoisDespues)
	}

	@Test
	def void bajaDeUnPoi() {
		pois.save(mockLocal)

		val nroPoisAntes = pois.allInstances.size

		pois.delete(mockLocal)

		val nroPoisDespues = pois.allInstances.size

		Assert.assertEquals(nroPoisAntes - 1, nroPoisDespues)
	}

	@Test
	def void actualizarDescripcionDeUnPoi() {
		pois.save(mockLocal)

		var localDB = pois.getById(mockLocal.id)

		Assert.assertEquals("", localDB.descripcion)

		mockLocal.descripcion = "Descripcion Nueva"

		pois.save(mockLocal)

		localDB = pois.getById(mockLocal.id)

		Assert.assertEquals("Descripcion Nueva", localDB.descripcion)
	}

	@Test
	def void deshabilitarUnPoi() {
		pois.save(mockLocal)

		var localDB = pois.getById(mockLocal.id)

		Assert.assertTrue(localDB.habilitado)

		mockLocal.habilitado = false

		pois.save(mockLocal)

		localDB = pois.getById(mockLocal.id)

		Assert.assertFalse(localDB.habilitado)
	}
}
