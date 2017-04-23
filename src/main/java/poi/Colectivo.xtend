package poi

import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import org.joda.time.DateTime
import poi.utils.Punto

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
class Colectivo extends POI {

	@OneToMany(cascade=ALL)
	@LazyCollection(LazyCollectionOption.FALSE) Set<Punto> paradas = newHashSet

	@Column
	int nroLinea

	override estaCerca(Punto coordenada) {
		paradas.exists[estaCerca(coordenada, 1)]
	}

	override coincideBusqueda(String string) {
		nroLinea.toString.coincideCon(string)
	}

	override estaDisponible(DateTime momento, String string) {
		estaDisponible(momento)
	}

	override estaDisponible(DateTime momento) {
		true
	}

	override getNombre() {
		"Linea " + nroLinea
	}

	override getDistancia(Punto coordenada) {
		paradas.minBy[distance(coordenada)].distance(coordenada)
	}

}
