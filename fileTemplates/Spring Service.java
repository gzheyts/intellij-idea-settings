#if ($PACKAGE_NAME && $PACKAGE_NAME != "")package $PACKAGE_NAME;#end

import org.springframework.stereotype.Service;

#parse("File Header.java")

@Service
public class ${NAME} {

}
