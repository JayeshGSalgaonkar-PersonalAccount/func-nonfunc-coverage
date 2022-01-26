package ntuc_memberportal

import com.intuit.karate.gatling.KarateProtocol
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_memberservice extends Simulation {

  val protocol: KarateProtocol = karateProtocol(
    "/membership/details/{nric}/{dob}" -> Nil,
    "membership/check/active/{nric}/{dob}" -> Nil,
    "eligibility/{nric}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")


  val member_Service: ScenarioBuilder = scenario("member-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/member-service/performance.feature"))


  setUp(
    member_Service.inject(constantConcurrentUsers(100).during(480)).protocols(protocol)
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))