#if ($PACKAGE_NAME && $PACKAGE_NAME != "")package $PACKAGE_NAME;#end

import org.springframework.stereotype.Controller;

#parse("File Header.java")

@Controller
public class ${NAME} {

}
