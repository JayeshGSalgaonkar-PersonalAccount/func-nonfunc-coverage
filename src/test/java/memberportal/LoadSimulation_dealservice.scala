package memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_dealservice extends Simulation {

  val deal_Service: ScenarioBuilder = scenario("deal-service").exec(karateFeature("classpath:memberportal/FeatureFiles/deal-service/performance.feature"))

  setUp(
    deal_Service.inject(constantConcurrentUsers(500).during(300))
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))