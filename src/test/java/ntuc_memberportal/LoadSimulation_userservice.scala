package ntuc_memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_userservice extends Simulation {

  val user_Service: ScenarioBuilder = scenario("user-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/user-service/performance.feature"))
  setUp(
    user_Service.inject(constantConcurrentUsers(1000).during(300)),
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))