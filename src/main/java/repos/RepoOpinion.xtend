package repos

import java.util.List
import poi.Opinion
import poi.POI

class RepoOpinion extends RepoMongoDB<Opinion> {

	static RepoOpinion instance

	static def RepoOpinion getInstance() {
		instance ?: new RepoOpinion
	}

	private new() {
	}

	override getEntityType() {
		Opinion
	}

	def List<Opinion> getOpiniones(POI poi) {
		ds.createQuery(entityType).field("poi").equal(poi.nombre).asList
	}
	
	override searchByExample(Opinion t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override defineUpdateOperations(Opinion t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
