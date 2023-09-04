package memberportal

import com.intuit.karate.gatling.KarateProtocol
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_userservice extends Simulation {

  val protocol: KarateProtocol = karateProtocol(
    "v1/postal-code/{postal-code}" -> Nil,
    "v1/user/userID/{scid}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val user_Service: ScenarioBuilder = scenario("user-service").exec(karateFeature("classpath:memberportal/FeatureFiles/user-service/performance.feature"))
  setUp(
    user_Service.inject(constantConcurrentUsers(500).during(300)).protocols(protocol),
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))