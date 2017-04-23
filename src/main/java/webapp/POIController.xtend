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
import repos.RepoPOI
import repos.RepoUsuario

@Controller
class POIController {
	extension JSONUtils = new JSONUtils

	@Post("/favorito/:idPoi/:idUsuario")
	def Result postFavorito() {
		val usuario = RepoUsuario.instance.searchById(Long::parseLong(idUsuario))
		try {
			val poi = RepoPOI.instance.searchById(Long::parseLong(idPoi))

			if (usuario.esFavorito(poi))
				usuario.removeFavorito(poi)
			else
				usuario.addFavorito(poi)
			
			RepoUsuario.instance.saveOrUpdate( usuario )
			
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok(usuario.toJson)
	}

	@Put("/opinion/:id")
	def Result putOpinion(@Body String body) {
		try {
			val poi = RepoPOI.instance.searchById(Long::parseLong(id))
			val opinion = body.fromJson(Opinion)
			poi.addOpinion(opinion)
			RepoPOI.instance.saveOrUpdate(poi)
		} catch (Exception e) {
			return badRequest(e.toJson)
		}
		return ok
	}

	@Get("/usuarios")
	def Result getUsuarios() {
		val usuarios = RepoUsuario.instance.allInstances
		response.contentType = ContentType.APPLICATION_JSON
		ok(usuarios.toJson)
	}

	@Get("/usuario/:id")
	def Result getUsuario() {
		val usuario = RepoUsuario.instance.searchById(Long::parseLong(id))
		response.contentType = ContentType.APPLICATION_JSON
		ok(usuario.toJson)
	}

	@Get("/pois")
	def Result getPois(String query) {
		val pois = RepoPOI.instance.searchByQuery(query)
		response.contentType = ContentType.APPLICATION_JSON
		ok(pois.toJson)
	}

	@Get("/poi")
	def Result getPoi(String id) {
		val poi = RepoPOI.instance.searchById(Long::parseLong(id))
		response.contentType = ContentType.APPLICATION_JSON
		ok(poi.toJson)
	}

	@Get("/poi/inhabilitar/:id")
	def Result inhabilitarPoi() {
		try {
			val poi = RepoPOI.instance.searchById(Long::parseLong(id))
			poi.habilitado = false
			RepoPOI.instance.saveOrUpdate(poi)
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}
	
	@Get("/poi/descripcion/:id")
	def Result descripcionPoi(String descripcion) {
		try {
			val poi = RepoPOI.instance.searchById(Long::parseLong(id))
			poi.descripcion = descripcion
			RepoPOI.instance.saveOrUpdate(poi)
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	def static void main(String[] args) {
		RepoPOI.instance.cargaInicial
		RepoUsuario.instance.cargaInicial
		XTRest.start(POIController, 9000)
	}
}
