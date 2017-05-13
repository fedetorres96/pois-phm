package repos.mysql

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
import repos.Repo
import poi.Opinion

abstract class RepoMySQL<T> implements Repo<T> {

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
		.addAnnotatedClass(Opinion)
		.addAnnotatedClass(RangoHorario)
		.buildSessionFactory()

	override allInstances() {
		val session = openSession
		try {
			session.createCriteria(entityType).list()
		} finally {
			session.close
		}
	}
	
	def T getById(Long id) {
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

	override save(T t) {
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
	
	override delete(T t) {
		val session = openSession
		try {
			session.beginTransaction
			session.delete(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw e
		} finally {
			session.close
		}
	}
	
	def Session openSession() {
		sessionFactory.openSession
	}
}
