package webapp

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import poi.Opinion
import repos.mongodb.RepoLog
import repos.mongodb.RepoOpinion
import repos.mysql.RepoPOI
import repos.mysql.RepoUsuario

@Controller
class POIController {

	extension JSONUtils = new JSONUtils

	RepoPOI pois = RepoPOI.instance
	RepoUsuario usuarios = RepoUsuario.instance
	RepoOpinion opiniones = RepoOpinion.instance
	RepoLog logs = RepoLog.instance

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

			opiniones.save(opinion)

		} catch (Exception e) {
			badRequest(e.toJson)
		}
		return ok
	}

	@Get("/usuario")
	def Result getUsuarios(String nombre, String contrasenia) {
		val usuario = usuarios.getUsuario(nombre, contrasenia)

		ok(usuario.toJson)
	}

	@Get("/usuario/:id")
	def Result getUsuario() {
		val idUsuario = Long::parseLong(id)

		val usuario = usuarios.searchById(idUsuario)

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

}
