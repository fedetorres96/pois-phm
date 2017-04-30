package repos

import java.util.List
import org.hibernate.HibernateException
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration
import org.hibernate.criterion.Restrictions
import poi.Banco
import poi.CGP
import poi.Colectivo
import poi.Local
import poi.POI
import poi.Rubro
import poi.Usuario
import poi.utils.Punto
import poi.utils.RangoHorario
import poi.utils.Servicio

abstract class RepoMySQL<T> {

	private static final SessionFactory sessionFactory = new Configuration()
		.configure()
		.addAnnotatedClass(Punto)
		.addAnnotatedClass(Rubro)
		.addAnnotatedClass(Servicio)
		.addAnnotatedClass(POI)
		.addAnnotatedClass(Banco)
		.addAnnotatedClass(CGP)
		.addAnnotatedClass(Colectivo)
		.addAnnotatedClass(Local)
		.addAnnotatedClass(Usuario)
		.addAnnotatedClass(RangoHorario)
		.buildSessionFactory()

	def List<T> allInstances() {
		val session = openSession
		try {
			
			session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def T searchById(Long id) {
        val session = openSession
        try {
            session.createCriteria(entityType)
          	.add(Restrictions.eq("id", id))
			.uniqueResult as T
        } catch (HibernateException e) {
            throw new RuntimeException(e)
        } finally {
            session.close
        }
    }

	def void saveOrUpdate(T t) {
		val session = openSession
		try {
			session.beginTransaction
			session.saveOrUpdate(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw e
		} finally {
			session.close
		}
	}
	
	def void DeleteById(long id) {
		var entity = searchById(id)
		val session = openSession
		try {
			session.beginTransaction
			session.delete(entity)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw e
		} finally {
			session.close
		}
	}
	
	def Class<T> getEntityType()

	def Session openSession() {
		sessionFactory.openSession
	}
}
