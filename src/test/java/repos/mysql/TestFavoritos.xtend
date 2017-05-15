package repos.mysql

import poi.Usuario
import org.junit.Before
import org.junit.After
import poi.Local
import org.junit.Test
import org.junit.Assert

class TestFavoritos {
	RepoUsuario usuarios
	RepoPOI pois

	Usuario mockUsuario
	Local mockLocal

	@Before
	def void init() {
		usuarios = RepoUsuario.instance
		pois = RepoPOI.instance

		mockUsuario = new Usuario => [
			nombre = "Mock Usuario"
			contrasenia = "Test"
		]

		mockLocal = new Local => [
			nombre = "Mock Shop"
			descripcion = ""
			habilitado = true
		]

		usuarios.save(mockUsuario)
		pois.save(mockLocal)
	}

	@After
	def void clean() {
		usuarios.delete(mockUsuario)
		pois.delete(mockLocal)
	}

	@Test
	def void seAgregaUnPoiAFavoritos() {
		var usuarioDB = usuarios.getById(mockUsuario.id)

		Assert.assertEquals(0, usuarioDB.listaFavoritos.size)
		Assert.assertFalse(usuarioDB.listaFavoritos.contains(mockLocal))

		mockUsuario.addFavorito(mockLocal)

		usuarios.save(mockUsuario)

		usuarioDB = usuarios.getById(mockUsuario.id)

		Assert.assertEquals(1, usuarioDB.listaFavoritos.size)
		Assert.assertFalse(usuarioDB.listaFavoritos.contains(mockLocal))
	}

	@Test
	def void seRemueveUnPoiDeFavoritos() {
		var usuarioDB = usuarios.getById(mockUsuario.id)

		Assert.assertEquals(0, usuarioDB.listaFavoritos.size)
		Assert.assertFalse(usuarioDB.listaFavoritos.contains(mockLocal))

		mockUsuario.addFavorito(mockLocal)

		usuarios.save(mockUsuario)

		usuarioDB = usuarios.getById(mockUsuario.id)

		Assert.assertEquals(1, usuarioDB.listaFavoritos.size)
		Assert.assertFalse(usuarioDB.listaFavoritos.contains(mockLocal))

		mockUsuario.removeFavorito(mockLocal)

		usuarios.save(mockUsuario)

		usuarioDB = usuarios.getById(mockUsuario.id)

		Assert.assertEquals(0, usuarioDB.listaFavoritos.size)
		Assert.assertFalse(usuarioDB.listaFavoritos.contains(mockLocal))
	}
}
