#if ($PACKAGE_NAME && $PACKAGE_NAME != "")package $PACKAGE_NAME;#end

import org.springframework.stereotype.Component;

#if ($Consumes != "")
import javax.ws.rs.Consumes;
#end
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

#parse("File Header.java")

@Component
#if ($Path != "")
    @Path("$Path")
#else
    @Path("/")
#end
#if ($Produces != "")
    @Produces("$Produces")
#else
    @Produces("application/json")
#end
#if ($Consumes != "")
    @Consumes("$Consumes")
#end
public class $NAME {
    //TODO Add JAX-RS REST methods using Allegro live templates
}
