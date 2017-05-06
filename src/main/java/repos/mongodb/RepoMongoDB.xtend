package repos.mongodb

import com.mongodb.MongoClient
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import poi.Log
import poi.Opinion

abstract class RepoMongoDB<T> {
	
	static protected Datastore ds
	static Morphia morphia

	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			
			morphia = new Morphia => [
				
				map(Opinion).
				map(Log)
				
				ds = createDatastore(mongo, "local")
				ds.ensureIndexes
			]
			
			println("Conectado a MongoDB. Bases en MongoDB: " + ds.getDB.collectionNames)
		}
	}
	
	def void save(T t) {
		ds.save(t)
	}
	
	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(entityType).asList
	}

	def Class<T> getEntityType()
}
