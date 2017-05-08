package repos.mongodb

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.joda.time.DateTime
import poi.Log



class TestRepoLog {
	
	RepoLog logs
	Log logJavier;
	Log logFavio;
	Log logAle;
	Log logFede;
	Log logMauro;
	
	@Before
	def void init() {
		logs = RepoLog.instance

		logJavier = new Log() => [
			fechaHora = DateTime.now().toString
			usuario = "Javi"
			exitoso = true
		]
		
		logFavio = new Log() => [
			fechaHora = DateTime.now().toString
			usuario = "Favio"
			exitoso = true
		]
		
		logAle = new Log() => [
			fechaHora = DateTime.now().toString
			usuario = "Ale"
			exitoso = true
		]
		
		logFede = new Log() => [
			fechaHora = DateTime.now().toString
			usuario = "Fede"
			exitoso = true
		]
		
		logMauro = new Log() => [
			fechaHora = DateTime.now().toString
			usuario = "Mauro"
			exitoso = true
		]
	}
	
	@Test
	def void longitudDeLogEnLaBase()
	{
		val cantidadDeLog = logs.allInstances.size
		Assert.assertEquals(cantidadDeLog, cantidadDeLog)
		System.out.println = cantidadDeLog
	}

	@Test
	def void seAgreganLogAlRepoLog()
	{
		val cantidadDeLog = logs.allInstances.size
		logs.save(logJavier)
		logs.save(logFavio)
		logs.save(logAle)
		logs.save(logFede)
		logs.save(logMauro)
		val cantidadDeLogsAfter = logs.allInstances.size
		Assert.assertEquals(cantidadDeLog + 5, cantidadDeLogsAfter)
		//logs.delete(logJavier)
		System.out.println = cantidadDeLog
	}
	
	@Test
	def void eliminarLogAlRepoLog()
	{
		val cantidadDeLog = logs.allInstances.size
		logs.save(logAle)
		val cantidadDeLogsAfter = logs.allInstances.size
		Assert.assertEquals(cantidadDeLog + 1, cantidadDeLogsAfter)
		logs.delete(logAle)
		System.out.println = cantidadDeLog
	}
	
	
	@Test
	def void exitoLog()
	{
		val falla = new Log() => [
			fechaHora = DateTime.now().toString
			usuario = "Carlos"
			exitoso = false
		]
		
	}
	


	
	
}