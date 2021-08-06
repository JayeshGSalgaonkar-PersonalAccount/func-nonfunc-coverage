import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

class TestRunner {

    @Karate.Test
    Karate myNTUC_TestRunner() {
        return Karate.run("classpath:ntuc_memberportal");

    }
}