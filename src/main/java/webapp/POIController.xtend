package webapp

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import poi.Opinion
import repos.RepoOpinion
import repos.RepoPOI
import repos.RepoUsuario
import repos.RepoLog
import poi.Log

@Controller
class POIController {
	
	extension JSONUtils = new JSONUtils

	static RepoPOI pois = RepoPOI.instance
	static RepoUsuario usuarios = RepoUsuario.instance
	static RepoOpinion opiniones = RepoOpinion.instance
	static RepoLog log = RepoLog.instance
	
	@Post("/favorito/:idPoi/:idUsuario")
	def Result postFavorito() {
		val usuario = usuarios.searchById(Long::parseLong(idUsuario))

		try {
			val poi = pois.searchById(Long::parseLong(idPoi))

			if (usuario.esFavorito(poi))
				usuario.removeFavorito(poi)
			else
				usuario.addFavorito(poi)

			usuarios.saveOrUpdate(usuario)

		} catch (Exception e) {
			badRequest(e.message)
		}
		ok(usuario.toJson)
	}

	@Put("/opinion/:id")
	def Result putOpinion(@Body String body) {
		try {
			val poi = pois.searchById(Long::parseLong(id))
			val opinion = body.fromJson(Opinion)

			opinion.poi = poi.nombre

			opiniones.create(opinion)

		} catch (Exception e) {
			return badRequest(e.toJson)
		}
		return ok
	}

	@Get("/usuarios")
	def Result getUsuarios() {
		val usuarios = usuarios.allInstances
		response.contentType = ContentType.APPLICATION_JSON
		ok(usuarios.toJson)
	}

	@Get("/usuario/:id")
	def Result getUsuario() {
		val usuario = usuarios.searchById(Long::parseLong(id))
		ok(usuario.toJson)
	}

	@Get("/pois")
	def Result getPois(String query) {
		val pois = pois.searchByQuery(query)
		ok(pois.toJson)
	}

	@Get("/poi")
	def Result getPoi(String id) {
		val poi = pois.searchById(Long::parseLong(id))
		ok(poi.toJson)
	}

	@Get("/poi/inhabilitar/:id")
	def Result inhabilitarPoi() {
		try {

			val poi = pois.searchById(Long::parseLong(id))
			poi.habilitado = false
			pois.saveOrUpdate(poi)
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	@Get("/poi/descripcion/:id")
	def Result descripcionPoi(String descripcion) {
		try {
			val poi = pois.searchById(Long::parseLong(id))

			poi.descripcion = descripcion

			pois.saveOrUpdate(poi)
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	def static void main(String[] args) {
		if (pois.allInstances.nullOrEmpty) {
			pois.cargaInicial
		}

		if (usuarios.allInstances.nullOrEmpty) {
			usuarios.cargaInicial
		}

		if (opiniones.allInstances.nullOrEmpty) {
			val usuarioTest = usuarios.allInstances.get(0)
			val poiTest = pois.allInstances.get(0)

			val opinion = new Opinion => [
				calificacion = 5
				comentario = "Mapea bien a MongoDB"
				usuario = usuarioTest.nombre
				poi = poiTest.nombre
			]

			opiniones.create(opinion)
		}
		
		if (log.allInstances.nullOrEmpty) {
			val usuarioTest = usuarios.allInstances.get(0)
			
			val l = new Log => [
				fecha = 11/01/1985
				hora = 21
				usuario = usuarioTest.nombre
				//usuario = usuarioTest.contrasenia
				//usuario.nombre = usuarioTest.nombre
				estado = estado
			]
			log.create(l)
		}

		XTRest.start(POIController, 9000)
	}
}
