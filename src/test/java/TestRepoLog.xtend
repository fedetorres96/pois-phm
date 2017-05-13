import org.joda.time.DateTime
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Log
import poi.Usuario
import repos.mongodb.RepoLog
import repos.mysql.RepoUsuario

class TestRepoLog{
	
	RepoUsuario usuarios
	RepoLog logs
	
	Usuario usuario
	
	Log log;
	
	@Before
	def void init() {
		usuarios = RepoUsuario.instance
		logs = RepoLog.instance
		
		usuario = new Usuario => [
			nombre = "Mock Usuario"
			contrasenia = "Test"
		]

		usuarios.save(usuario)
		
		log = new Log()
		log.usuario = usuario
		log.exitoso =  true
		log.fechaHora = DateTime.now.toString	

	}
	
	@Test
	def void seAgreganLogAlRepoLog()
	{
		val nroLogsActual = logs.allInstances.size
		
		logs.save(log)
		
		val nroLogsDespues =  logs.allInstances.size
		
		Assert.assertEquals( nroLogsActual + 1 , nroLogsDespues)
	}
	
	@Test
	def void eliminarLogAlRepoLog()
	{
		logs.save(log)
		
		val nroLogsActual = logs.allInstances.size
		
		logs.delete(log)
		
		val nroLogsDespues =  logs.allInstances.size

		Assert.assertEquals( nroLogsActual - 1 , nroLogsDespues)
	}
	
	@After
	def void clean(){
		usuarios.delete(usuario)
		logs.delete(log)
	}
	
}
