package poi

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import poi.utils.Punto
import repos.RepoOpinion

@Accessors
@JsonIgnoreProperties(ignoreUnknown=true)
@Inheritance(strategy=TABLE_PER_CLASS)
@Entity
abstract class POI {

	@Id
	@GeneratedValue
	public Long id
	
	@Column(length=300)
	String descripcion
	
	@Column(length=150)
	String domicilio
	
	@Column
	boolean habilitado

	def boolean estaCerca(Punto coordenada)

	def boolean coincideBusqueda(String string)

	def boolean estaDisponible(DateTime momento, String string)

	def boolean estaDisponible(DateTime momento)

	def Double getDistancia(Punto coordenada)

	def String getNombre()
	
	def String getTipo() {
		class.name.replace("poi.", "")
	}
	
	def List<Opinion> getListaOpiniones() {
		RepoOpinion.instance.getOpiniones(this)
	}
	
	def double getCalificacion(){
		val divisor = if (listaOpiniones.size > 0) listaOpiniones.size else 1
		val promedio = listaOpiniones.fold(0.0)[ acum, o | acum + o.calificacion ] / divisor
		Math.round(promedio * 100.0) / 100.0
	}
	

}
