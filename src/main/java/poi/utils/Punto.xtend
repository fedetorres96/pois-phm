package poi.utils

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Entity
@Accessors
class Punto {
	
	new () {
		
	}
	
	new(double _x, double _y){
		x = _x
		y = _y
	}
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	double x;
	
	@Column
	double y;
	
	def double distance(Punto punto){
		point.distance(punto.point)
	}
	
	def Point getPoint(){
		new Point(x, y)
	}
}