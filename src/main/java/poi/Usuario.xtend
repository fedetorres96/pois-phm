package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import poi.utils.Punto

@Accessors
@Entity
@JsonIgnoreProperties(ignoreUnknown=true)
class Usuario {

	@Id
	@GeneratedValue
	public Long id

	@Column(length=150)
	String nombre

	@Column(length=150)
	String contrasenia

	@ManyToOne(cascade=ALL)
	Punto ubicacion

	@JsonIgnore
	@ManyToMany(cascade=ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	List<POI> listaFavoritos = newArrayList

	def void addFavorito(POI poi) {
		listaFavoritos.add(poi)
	}

	def void removeFavorito(POI _poi) {
		val poi = listaFavoritos.findFirst[ poi | poi.id == _poi.id ]
		listaFavoritos.remove(poi)
	}

	def boolean esFavorito(POI _poi) {
		listaFavoritos.exists[ poi | poi.id == _poi.id ]
	}

	@JsonProperty("listaFavoritos")
	def List<Long> getListaFavoritosJSON() {
		listaFavoritos.map[poi|poi.id]
	}

}
