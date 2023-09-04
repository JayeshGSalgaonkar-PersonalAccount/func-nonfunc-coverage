package ntuc_memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_notificationservice extends Simulation {

  val notification_Service: ScenarioBuilder = scenario("notification-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/notification-service/performance.feature"))


  setUp(
    notification_Service.inject(constantConcurrentUsers(500).during(300)),
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))