package repos.mysql

import poi.Opinion
import java.util.List
import poi.POI
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException

class RepoOpinionMySQL extends RepoMySQL<Opinion> {

	static RepoOpinionMySQL instance

	static def RepoOpinionMySQL getInstance() {
		instance ?: new RepoOpinionMySQL
	}

	private new() {
	}

	override getEntityType() {
		Opinion
	}
	
	def List<Opinion> getOpiniones(POI poi) {
        val session = openSession
        try {
            session.createCriteria(entityType)
          	.add(Restrictions.eq("poi", poi))
			.list
        } catch (HibernateException e) {
            throw new RuntimeException(e)
        } finally {
            session.close
        }
    }
}
