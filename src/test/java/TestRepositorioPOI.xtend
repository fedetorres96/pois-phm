import creacionales.POIBuilder
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Colectivo
import poi.Local
import poi.Opinion
import repos.RepoPOI

class TestRepositorioPOI {
	RepoPOI repoPoi
	Opinion opinion;
	Opinion badOpinion;
	Opinion badOpinion1;
	Colectivo linea2; 
	Local trigoDeOro;
	Local local1;
	
	@Before
	def void init(){
		repoPoi = RepoPOI.instance
		opinion = new Opinion() =>[
			calificacion = 4
			comentario = "prueba"
			usuario = "Favio"
		]
		
		
		badOpinion = new Opinion() =>[
			calificacion = 7
			comentario = "prueba 2"
			usuario = "Fede"
		]
		
		badOpinion1 = new Opinion() =>[
			calificacion = -1
			comentario = "prueba 2"
			usuario = "Fede"
		]
		
		linea2 = new POIBuilder()
			.colectivo
			.numero(2)
			.domicilio("Tomas lubary 555")
			.parada(1, 1)
			.parada(2, 1)
			.parada(3, 1)
			.parada(4, 1)
			.build	
		
		
		trigoDeOro = new POIBuilder()
			.local.nombre("Trigo de Oro")
			.clave("pan")
			.clave("facturas")
			.domicilio("Alcorta 3798")
			.ubicacion(11, 7)
			.horario(#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0)
			.build
			
		local1 = new POIBuilder()
			.local.nombre("local1")
			.clave("Frutas")
			.clave("Verduras")
			.domicilio("Maipu 2010")
			.ubicacion(1, 10)
			.horario(#["Jueves", "Viernes", "Domingo"], 7, 0, 20, 0)
			.build
				
	}
	
	/* TODO: Hacerlo para MongoDB
	@Test
	def void opinionAgregadaOk(){
		repoPoi.saveOrUpdate(linea2)
	
		var colectivo = repoPoi.searchById(linea2.id)
		
		Assert.assertEquals(0, colectivo.listaOpiniones.size)
		
		colectivo.addOpinion(opinion)
		
		repoPoi.saveOrUpdate(colectivo)
		
		colectivo = repoPoi.searchById(linea2.id)
		
		Assert.assertEquals(1, colectivo.listaOpiniones.size)
		
		repoPoi.DeleteById(linea2.id)
	}*/
	
	@Test
	def void poiDadoDeBajaOK(){
		repoPoi.saveOrUpdate(trigoDeOro)
		
		var local = repoPoi.searchById(trigoDeOro.id)
		
		Assert.assertTrue(local.habilitado)
		
		local.habilitado = false
		
		repoPoi.saveOrUpdate(local)
		
		local = repoPoi.searchById(trigoDeOro.id)
		
		Assert.assertFalse(local.habilitado)
		
		repoPoi.DeleteById(trigoDeOro.id)
	}
	
	@Test
	def void poiCreadoHabilitadoOK(){
		repoPoi.saveOrUpdate(local1)
		
		val local = repoPoi.searchById(local1.id)
		
		Assert.assertTrue(local.habilitado)
		
		repoPoi.DeleteById(local1.id)
	}
	
	
	
	@Test
	def void localUpdateOK(){
		repoPoi.saveOrUpdate(trigoDeOro)
		
		var local = repoPoi.searchById(trigoDeOro.id)
		val descripcionVieja = local.descripcion 
		
		Assert.assertEquals(descripcionVieja, local.descripcion)		
		
		val descripcionNueva = "Local Limpio"
		
		local.descripcion = descripcionNueva
		
		repoPoi.saveOrUpdate(local)
		
		local = repoPoi.searchById(trigoDeOro.id)
		
		Assert.assertNotEquals(descripcionVieja, local.descripcion)
		Assert.assertEquals(descripcionNueva, local.descripcion)
		
		repoPoi.DeleteById(trigoDeOro.id)
	}
	
	/* TODO: Hacerlo para MongoDB
	@Test(expected=HibernateException)
	def void opinionconCalificacionMayorA5NoSeAgrega(){
		trigoDeOro.addOpinion(badOpinion)
		
		repoPoi.saveOrUpdate(trigoDeOro)
	}
	
	@Test(expected=HibernateException)
	def void opinionconCalificacionMenorA1NoSeAgrega(){
		trigoDeOro.addOpinion(badOpinion1)
		
		repoPoi.saveOrUpdate(trigoDeOro)
	}*/
}
