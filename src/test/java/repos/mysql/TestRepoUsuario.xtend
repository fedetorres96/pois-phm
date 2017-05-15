package repos.mysql

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.Usuario

class TestRepoUsuario {
	RepoUsuario usuarios

	Usuario mockUsuario

	@Before
	def void init() {
		usuarios = RepoUsuario.instance

		mockUsuario = new Usuario => [
			nombre = "Mock Usuario"
			contrasenia = "Test"
		]

	}

	@After
	def void clean() {
		val usuarioDB = usuarios.getById(mockUsuario.id)
		
		if (usuarioDB != null) {
			usuarios.delete(mockUsuario)
		}
	}

	@Test
	def void altaDeUnUsuario() {
		val nroUsuariosAntes = usuarios.allInstances.size

		usuarios.save(mockUsuario)

		val nrousuariosDespues = usuarios.allInstances.size

		Assert.assertEquals(nroUsuariosAntes + 1, nrousuariosDespues)
	}

	@Test
	def void bajaDeUnUsuario() {
		usuarios.save(mockUsuario)

		val nroUsuariosAntes = usuarios.allInstances.size

		usuarios.delete(mockUsuario)

		val nrousuariosDespues = usuarios.allInstances.size

		Assert.assertEquals(nroUsuariosAntes - 1, nrousuariosDespues)
	}

}
