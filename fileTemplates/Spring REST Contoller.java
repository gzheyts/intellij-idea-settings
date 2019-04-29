#if ($PACKAGE_NAME && $PACKAGE_NAME != "")package $PACKAGE_NAME;#end

import org.springframework.web.bind.annotation.RestController;

#parse("File Header.java")

@RestController
public class ${NAME} {
    //TODO Add Spring REST methods using Allegro live templates
}
