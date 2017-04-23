package poi

import java.util.List
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import org.joda.time.DateTime
import poi.utils.Poligono
import poi.utils.Punto
import poi.utils.Servicio

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
class CGP extends POI {

	@Column
	int nroComuna

	@ManyToOne(cascade=ALL)
	Punto ubicacion
	
	@ManyToMany(cascade=ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	List<Punto> limites = newArrayList
	
	@OneToMany(cascade=ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	Set<Servicio> servicios = newHashSet

	override estaCerca(Punto coordenada) {
		Poligono.isInside(limites, coordenada)
	}

	override coincideBusqueda(String string) {
		nroComuna.toString.coincideCon(string) || servicios.exists[coincideNombre(string)]
	}

	override estaDisponible(DateTime momento, String string) {
		servicios.exists[estaDisponible(momento) && coincideNombre(string)]
	}

	override boolean estaDisponible(DateTime momento) {
		servicios.exists[estaDisponible(momento)]
	}

	override getNombre() {
		"CGP " + nroComuna
	}

	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}
}
