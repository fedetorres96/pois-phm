package repos.mongodb

import poi.Opinion

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
}
