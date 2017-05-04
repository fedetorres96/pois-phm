package repos

import com.mongodb.MongoClient
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import poi.Opinion
import org.mongodb.morphia.query.UpdateOperations

abstract class RepoMongoDB<T> {
	
	static protected Datastore ds		//acceso al datastore de Mongo
	static Morphia morphia				//acceso a Morphia en una variable static

	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			
			morphia = new Morphia => [
				
				map(Opinion)
				//map(UsuarioMongo)
				
				ds = createDatastore(mongo, "local")
				ds.ensureIndexes
			]
			
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}
	
	def T getByExample(T example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}
	
	//Criterio de Busqueda
	def List<T> searchByExample(T t)
	
	def T createIfNotExists(T t) {
		val entidadAModificar = getByExample(t)
		if (entidadAModificar != null) {
			return entidadAModificar
		}
		create(t)
	}
	
	def T create(T t) {
		ds.save(t)
		t
	}
	
	def void update(T t) {
		ds.update(t, this.defineUpdateOperations(t))
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)
	
	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(entityType).asList
	}

	def Class<T> getEntityType()
}
