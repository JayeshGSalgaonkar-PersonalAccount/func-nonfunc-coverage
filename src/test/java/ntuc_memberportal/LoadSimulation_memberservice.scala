package ntuc_memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_memberservice extends Simulation {


  val member_Service: ScenarioBuilder = scenario("member-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/member-service/performance.feature"))


  setUp(
    member_Service.inject(constantConcurrentUsers(400).during(480)),
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))