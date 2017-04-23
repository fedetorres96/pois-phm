package creacionales

import poi.CGP
import poi.utils.Punto
import poi.utils.Servicio

class CGPBuilder {
	CGP cgp = new CGP => [
		//poligono = new Poligono
	]
	
	def build() {
		cgp.habilitado = true
		cgp
	}

	def comuna(int numero) {
		cgp.nroComuna = numero
		this
	}
	
	def ubicacion(double x, double y){
		cgp.ubicacion = new Punto(x, y)
		this
	}
	
	def ubicacion(int x, int y){
		cgp.ubicacion = new Punto(x, y)
		this
	}

	def limite(double x, double y) {
		//cgp.poligono.addLimites(new Punto(x, y))
		cgp.limites.add(new Punto(x, y))
		this
	}
	
	def domicilio(String _domicilio){
		cgp.domicilio = _domicilio
		this
	}

	def servicio(String nombreServicio) {
		cgp.servicios.add(new Servicio => [nombre = nombreServicio])
		this
	}

	def servicio(Servicio servicio) {
		cgp.servicios.add(servicio)
		this
	}

	def servicios(Iterable<Servicio> coleccionServicios) {
		cgp.servicios = coleccionServicios.toSet
		this
	}
}
