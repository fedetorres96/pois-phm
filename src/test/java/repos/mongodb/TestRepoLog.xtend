package repos.mongodb

import java.util.Date
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Log
import poi.Usuario
import repos.mongodb.RepoLog
import repos.mysql.RepoUsuario

class TestRepoLog {
	RepoUsuario usuarios
	RepoLog logs

	Usuario mockUsuario

	Log log;

	@Before
	def void init() {
		usuarios = RepoUsuario.instance
		logs = RepoLog.instance

		mockUsuario = new Usuario => [
			nombre = "Mock Usuario"
			contrasenia = "Test"
		]

		usuarios.save(mockUsuario)

		log = new Log() => [
			usuario = mockUsuario.nombre
			exitoso = true
			fechaHora = new Date()
		]
	}

	@After
	def void clean() {
		usuarios.delete(mockUsuario)
		logs.delete(log)
	}

	@Test
	def void altaDeUnLog() {
		val nroLogsActual = logs.allInstances.size

		logs.save(log)

		val nroLogsDespues = logs.allInstances.size

		Assert.assertEquals(nroLogsActual + 1, nroLogsDespues)
	}

	@Test
	def void bajaDeUnLog() {
		logs.save(log)

		val nroLogsActual = logs.allInstances.size

		logs.delete(log)

		val nroLogsDespues = logs.allInstances.size

		Assert.assertEquals(nroLogsActual - 1, nroLogsDespues)
	}

}
