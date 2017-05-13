import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Local
import poi.Opinion
import poi.Usuario
import repos.mysql.RepoOpinionMySQL
import repos.mysql.RepoPOI
import repos.mysql.RepoUsuario

class TestRepoPOI {
	RepoPOI pois
	RepoUsuario usuarios
	RepoOpinionMySQL opiniones

	Opinion opinion1
	Opinion opinion2
	Opinion opinion3

	Usuario fede
	Usuario mauro
	Usuario ale

	Local mockLocal

	@Before
	def void init() {
		pois = RepoPOI.instance
		usuarios = RepoUsuario.instance
		opiniones = RepoOpinionMySQL.instance

		fede = new Usuario => [
			nombre = "Fede"
		]

		mauro = new Usuario => [
			nombre = "Mauro"
		]

		ale = new Usuario => [
			nombre = "Ale"
		]

		usuarios.save(fede)
		usuarios.save(mauro)
		usuarios.save(ale)

		mockLocal = new Local => [
			nombre = "Mock Shop"
			descripcion = ""
			habilitado = true

		]

		pois.save(mockLocal)


		opinion1 = new Opinion() => [
			calificacion = 5
			comentario = "Opinion 1"
			usuario = fede
			poi = mockLocal
		]

		opinion2 = new Opinion() => [
			calificacion = 1
			comentario = "Opinion 2"
			usuario = mauro
			poi = mockLocal
		]

		opinion3 = new Opinion() => [
			calificacion = 3
			comentario = "Opinion 3"
			usuario = ale
			poi = mockLocal
		]
	}

	@Test
	def void poiDadoDeBajaOK() {

		var localDB = pois.getById(mockLocal.id)

		Assert.assertTrue(localDB.habilitado)

		mockLocal.habilitado = false

		pois.save(mockLocal)

		localDB = pois.getById(mockLocal.id)

		Assert.assertFalse(localDB.habilitado)

	}

	@Test
	def void localUpdateOK() {

		var localDB = pois.getById(mockLocal.id)

		Assert.assertEquals("", localDB.descripcion)

		mockLocal.descripcion = "Descripcion Local"

		pois.save(mockLocal)

		localDB = pois.getById(mockLocal.id)

		Assert.assertEquals("Descripcion Local", localDB.descripcion)

	}

	@Test
	def void altaDeUnaOpinion() {

		val nroOpinionesActual = opiniones.allInstances.size

		opiniones.save(opinion1)

		var nroOpinionesDespues = opiniones.allInstances.size

		Assert.assertEquals(nroOpinionesActual + 1, nroOpinionesDespues)

	}

	@Test
	def void calificacionPromedioDeUnPOI() {
		
		opiniones.save(opinion1)
		opiniones.save(opinion2)
		opiniones.save(opinion3)

		Assert.assertEquals(3.0, mockLocal.calificacion, 0)

	}

	@After
	def void clean() {

		pois.delete(mockLocal)

		usuarios.delete(fede)
		usuarios.delete(mauro)
		usuarios.delete(ale)

		opiniones.delete(opinion1)
		opiniones.delete(opinion2)
		opiniones.delete(opinion3)
	}

/* 
 * @Test
 * def void opinionAgregadaOk(){
 * 	repoPoi.saveOrUpdate(linea2)
 * 
 * 	var colectivo = repoPoi.searchById(linea2.id)
 * 	
 * 	Assert.assertEquals(0, colectivo.listaOpiniones.size)
 * 	
 * 	colectivo.addOpinion(opinion)
 * 	
 * 	repoPoi.saveOrUpdate(colectivo)
 * 	
 * 	colectivo = repoPoi.searchById(linea2.id)
 * 	
 * 	Assert.assertEquals(1, colectivo.listaOpiniones.size)
 * 	
 * 	repoPoi.DeleteById(linea2.id)
 * }
 * 
 * @Test(expected=HibernateException)
 * def void opinionconCalificacionMayorA5NoSeAgrega(){
 * 	trigoDeOro.addOpinion(badOpinion)
 * 	
 * 	repoPoi.saveOrUpdate(trigoDeOro)
 * }
 * 
 * @Test(expected=HibernateException)
 * def void opinionconCalificacionMenorA1NoSeAgrega(){
 * 	trigoDeOro.addOpinion(badOpinion1)
 * 	
 * 	repoPoi.saveOrUpdate(trigoDeOro)
 * }
 */
}
