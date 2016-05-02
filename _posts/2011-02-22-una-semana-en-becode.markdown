Una semana en BeCode
es
2011-02-22
Retrospectiva de la semana que pasé en Valencia trabajando con la gente de BeCode

---

## Comenzando la semana

Desde la habitación del hotel en Valencia recojo <a href="http://twitter.com/#!/kinisoftware/statuses/39808757890289664" target="_blank">el guante que me lanzó Kini</a>. Que conste que ya lo tenía pensado desde que supe que iba a venir a <a href="http://www.becodemyfriend.com/" target="_blank">Be Code</a>, pero no está de mas darle el crédito del empujón final.

Comienzo a escribir con un día de retraso, porque ayer estaba demasiado cansadocomo para escribir nada. Me había levantado a las 6 de la mañana para coger el AVE a las 7, estar en Valencia a las 9 y, así, aprovechar bien el lunes. El madrugón y lo intenso que fue el primer día acabaron conmigo. Así que hoy os contaré lo que hice ayer, mañana lo que he hecho hoy, etc...

Nada más llegar a Valencia me dirigí a la oficina de BeCode en <a href="http://maps.google.es/maps?f=q&source=s_q&hl=es&geocode=&q=el+carmen+valencia&aq=&sll=40.396764,-3.713379&sspn=8.681468,19.753418&ie=UTF8&hq=el+carmen&hnear=Valencia,+Comunidad+Valenciana&z=13&iwloc=A&cid=16912536998814116647" target="_blank">el barrio del Carmen</a>. He de reconocer que no era para nada lo que me esperaba: Ningún tipo de cartel en la puerta ni nada de imagen de marca en el edificio. Quién va a Be Code **sabe a lo que va y porqué está allí**. Su lugar de trabajo es el vivo ejemplo de que el hábito no hace al monje.

Dentro, dos plantas. La baja con tan sólo un par de puestos con sus respectivos iMacs pidiendo cariño. La de arriba es _where things happen_. Otros seis puestos, pizarra, y un panel de corcho **enorme** con tarjetas (que no postits) de varios colores.  Allí, a lo largo del día, conocí a la mayor parte de la gente que forma Be Code: Aitor, Luis y Marina. Pude comprobar en mis carnes el buen rollo que hay entre ellos.

En una cafetería cercana <a href="http://twitter.com/#!/xav1uzz" target="_blank">Xavi</a>, el alma de Be Code, me contó como íbamos a pasar la semana. La idea era arrancar un proyecto muy chulo que se trae entre manos y que había gandado el startup weekend de Barcelona. (Ya os contaré un poco más de qué va y en qué consiste tecnológicamente cuando pida permiso :-)).

Nuestro objetivo para el primer día fue montar la estructura del proyecto y ponerlo en funcionamiento en el entorno de integración contínua. Teníamos que integrar un framework javascript que habían desarrollado en Be Code sobre <a href="http://mootools.net/" target="_blank">Mootools</a>.

Para implementar las pruebas añadimos <a href="http://pivotal.github.com/jasmine/" target="_blank">Jasmine</a> a la ecuación. Un framework para BDD con Javascript que me ha encantado por parecerse _mucho_ a RSpec.

Para hacer estas cosillas no estuvimos en pareja la mayor parte del tiempo. Yo me encargué de preparar la estructura del proyecto y el _script_ rake para lanzar los tests del proyecto mientras Xavi se pegaba con el señor Hudson. Fue bastante divertido hasta que tuvimos que pegarnos con Selenium en el servidor de integración contínua.

Necesitábamos Selenium para poder lanzar los tests de Jasmine. Como se trata de un equipo _headless_ tuvimos que instalar unas <a href="http://en.wikipedia.org/wiki/Xvfb" target="_blank">X virtuales sobre _framebuffer_</a> y conseguir que Selenium utilizara ese _display_ para lanzar el navegador. Conseguimos configurarlo y tenerlo funcionando con nuestro usuario en el servidor pero no con el usuario de Hudson.

Estuvimos pegándonos hasta bastante tarde con ello, pero decidimos dejarlo para el día siguiente. Nuestras cabezas estarían más despejadas y probablemente daríamos antes la solución.

### Actualización: sobre Shift'o'rama

Después de pedir permiso puedo contar en qué consiste el proyecto y qué tecnologías van a utilizar.

El proyecto se llama Shift'o'rama y es una herramienta para gestionar los turnos de los trabajadores. Podéis ver un <a href="http://www.shiftorama.com/" target="_blank">esbozo del proyecto _online_</a>. Obviamente se trata de una aplicación web :·)

Respecto a la tecnología, la parte del _frontend_ va a utilizar el framework del que os he estado hablando y que aquí conocen como _Core_. La verdad es que la arquitectura es una pasada. Xavi me estuvo contando todas las posibilidades que se abrían con ella de cara a tener diferentes niveles de caché, internacionalización, etc...  Es una arquitectura orientada completamente a eventos e incorpora una serie de componentes que cubren las necesidades básicas. Lo mejor es que tienen idea de liberarlo como proyecto _Open Source_.

El _backend_ van a implementarlo con Ruby (Yay! :·D). Como Ruby on Rails es un _stack_ demasiado pesado van a utilizar <a href="http://www.sinatrarb.com/" target="_blank">Sinatra</a>. La pega es que esta semana vamos a trabajar únicamente con Javascript y yo no voy a tocar Ruby más que en el _Coding Dojo_ del viernes y en los `Rakefile`.


## Segundo día

Pese a lo que cabía esperar, no empezamos arreglando el problema de Hudson. En un bonito ejemplo de uso de _Timeboxing_ el problema con Selenium pasó al panel como deuda técnica (tarjetita gris :P) en la sección dedicada a impedimentos. Teníamos que empezar a aportar valor y, teniendo en cuenta que los únicos que íbamos a trabajar en Shift'o'rama por ahora éramos Xavi y yo, no era algo crítico.

Así que el día comenzó definiendo las tareas que teníamos que completar para conseguir implementar la historia que teníamos como objetivo: _crear un turno semanal_.

Nos salieron cinco. Pero en Be Code ya tienen preparado otro color (verde) para las tareas emergentes (las que vemos que son necesarias cuando estamos metidos en harina). Las cinco tareas tenían un claro orden lógico para implementarlas. Pero Xavi me dijo que, para demostrar que estas dependencias que nos parecen obvias, realmente no son dependencias, las íbamos a implementar en un orden aleatorio. De hecho, las tarjetas de las tareas, que son de color amarillo, acabaron en la pizarra ¡dadas la vuelta!

Así que le dimos la vuelta a la primera y comenzamos a escribir especificaciones con Jasmine. Pusimos el tomatómetro y empezamos a quemar pomodoros. Cada pomodoro que quemábamos acababa apuntado en la tarjeta de la tarea. Así podíamos saber cuantos pomdoros consumíamos con cada tarea. El tiempo se me pasó volando. Antes de comer habíamos hecho 7 pomodoros.

Respecto a la técnica me sorprendió mucho que Xavi no cae en ningún tipo de dogmatismo cuando hace TDD. Se nota que sabe lo que está haciendo y que busca que las cosas funcionen. Me gustó mucho como extrajimos clases de la implementación inicial y como saltábamos de una clase a otra cuando necesitábamos añadir responsabilidad en otro punto. Eso sí, siempre con un test por delante. Fue una gran lección de diseño top-down.

Además, al tratarse de Javascript, se podía ver perfectamente como la implementación resultante de los tests se convertía en algo tangible. Una gozada.

La tarde siguió por el mismo camino después de comer muy rico y al aire libre (el clima de Valencia es una gozada). De postre tuvimos <a href="http://twitter.com/jacegu/statuses/40067461617287170" target="_blank">tarta casera</a> que trajo Marina para celebrar su cumpleaños.

Al cabo del día habíamos completado 13 pomodoros y habíamos terminado 3 de las 5 tareas, una tarea emergente, solventadas dos tareas de _deuda técnica_ con las que nos encontramos e incluso corregido un bug en el _Core_ Javascript. Para el día siguiente nos dejamos una tarea emergente que tenía una pinta más que interesante.

Fuera de lo estrictamente técnico el día tuvo algo que me resultó muy impactante. Después de comer vino una chica bastante joven con una idea de proyecto con el objetivo de preguntar a la gente de Be Code unas cuantas dudas respecto a costes técnicos, estimaciones, etc...

Más allá de que tanto Xavi como Luis le resolvieran todas las dudas lo mejor que pudieran sin cobrar por ello y de que le ofrecieran venir a Be Code a desarrollar su idea sin ningún compromiso, lo que más me impactó fue la honestidad. **Nada de intentar aprovecharse** de una joven con poca o ninguna experiencia para quedarse con el poco dinero que tendría. **Nada de darle falsas expectativas**. **Nada de asumir que algo se puede hacer en cualquier circunstancia**. Simplemente **la verdad**.

Además la chica salió de allí con el ofrecimiento de Be Code para colaborar en el proyecto de un montón de formas distintas. Hasta ahora sólo había oído cosas como estas de la boca de Enrique y Xavi cuando nos contaban su forma de trabajar. No había podido disfrutar de una relación parecida a "proveedor-cliente" con estos niveles de honestidad y sinceridad en primera persona. Verdaderamente recomendable.


## Tercer día

El tercer día siguió por los mismos derroteros que el anterior. Comenzamos justo por dónde lo habíamos dejado: implementando la tarea emergente que detectamos el martes.

La diferencia fue que ya me encontraba mucho más suelto con Javascript y estaba más familiarizado con la arquitectura del framework, así que avanzamos mucho más rápido. En los seis pomodoros que hicimos antes de comer ya habíamos conseguido terminar la tarea y eso que tenía bastante miga. Fue más divertido que el día anterior en el que había momentos en los que me costaba bastante más seguir a Xavi.

La tarde fue más relajada que la del día anterior. Compartimos un primer pomodoro en el que dimos la vuelta a la siguiente tarea. Comenzamos a dar los primeros pasos con ella pero pronto Xavi tuvo que empezar a prestar atención a otros asuntos del día a día de Be Code.

Esto me dio la oportunidad de soltarme y comenzar a dar pequeños pasitos solo sin su supervisión. De vez en cuando él se pasaba por allí iba echando un ojo para que las cosas no se salieran de madre. Dos pomodoros después yo había conseguido terminar la tarea sólo, refactorizar parte del código de producción y de un par de tests.

Mientras escribo esto me estoy dando cuenta de que después de un día y medio de _pair programming_ ya había sido capaz de ser mínimamente productivo con un framework y una tecnología que me eran *completamente desconocidas*. Nada de pasarme 15 días leyendo manuales antes de poder hacer algo. Es algo que tendré muy en cuenta la próxima vez que tenga que enseñar algo a alguien. Es un ejemplo muy ilustrativo de como tener un mentor es la mejor forma de aprender (además de ser la más rápida).

Una vez terminada la tarea, no me vi con la suficiente confianza como para seguir con la siguiente. Así que, aprovechando que Xavi estaba en una reunión, me dediqué a escribir en el blog (mucho mejor que hacerlo desde el hotel tirando de 3G).

Aunque el día fue menos productivo que el anterior y tuve menos tiempo para programar con Xavi me resultó increíblemente divertido. El día siguiente prometía ser muy interesante ya que yo no iba a ser el <a href="http://twitter.com/wolframkriesing/statuses/40703570600931328" target="_blank">único</a> que estaría de visita en Be Code.

Como colofón final nos tomamos unas cañas con <a href="http://twitter.com/#!/hell03610" target="_blank">Emma</a> y aprovechamos para comentar un poco <a href="http://www.becodemyfriend.com/2011/02/coding-dojo-el-proximo-25-de-febrero/" target="_blank">el dojo</a> del viernes.


## Cuarto día

El jueves comenzó con una desagradable sorpresa. Nada más llegar a Be Code me entero de que no hay internet. Con la esperanza de que volviera pronto me junté con Xavi para solventar una pequeña deuda técnica que teníamos pendiente. No nos llevó mucho tiempo. A los pocos segundos de hacer _commit_ llamó a la puerta de Be Code <a href="http://twitter.com/#!/wolframkriesing" target="_blank">Wolfram</a>.

Wolfram es uno de los fundadores de <a href="http://uxebu.com/" target="_blank">Uxebu</a>. Se trata de una pequeña empresa fundada en Alemania que se especializa en el desarrollo Javascript. Estaba de paso por Valencia y aprovechó para pasar el día con nosotros. O esa era la idea hasta las dificultades técnicas :-P

%pDada la coyuntura nos dirigimos a un café cercano a charlar y a ponernos al día de qué hacía cada uno. Pudimos enterarnos de como trabajan en Uxebu y a qué se dedicaban exactamente. Me resultó muy curioso saber que una empresa puede hacer negocio dedicándose únicamente a una tecnología tan concreta como Javascript. Es un territorio que me es completamente desconocido y en el que realmente quiero y debo ponerme al día. Sobre todo si pretendo seguir desarrollando aplicaciones web.

Cuando volvimos a la oficina Xavi enseñó un poco las tripas de _Core.js_ a Wolfram y le contó un poco como iba la arquitectura. En un ejercicio de reciprocidad él nos enseñó parte de su trabajo. Lo qué más impresionado me dejó fueron las aplicaciones para móviles que tenían completamente desarrolladas mediante Javascript y HTML5. No hubiera dicho que eso era Javascript **NUNCA**. Me dejó helado. También nos comentó que había estado probando <a href="http://nodejs.org/">Node.js</a> y que le había encantado (<a href="http://twitter.com/#!/plagelao" target="_blank">@plagelao</a> esta va por ti ;)). Al parecer Javascript es un mundo mucho más fértil de lo que me habían inducido a creer...

Como internet se negaba a funcionar y Wolfram tenía que atender a su _stand up meeting_ distribuído a través de Skype nos despedimos con la promesa de que volvería al día siguiente si las dificultades técnicas nos lo permitían.

La tarde fue bastante diferente a las anteriores y, salvo un pequeño inciso, tuvo más de social que de tecnológica. Xavi tuvo una reunión que terminó bastante tarde lo que provocó que terminásemos más merendando que comiendo. Así que en vez de volver a Be Code dimos un paseo por Valencia y aprovechamos para hablar largo y tendido.

Aún así y todo nos pasamos por casa de Xavi para hacer un pequeño _spike_ y mirar como añadir una _feature_ a <span class="code">Core.js</span> que Wolfram nos había comentado que estaba disponible en <a href="http://dojotoolkit.org/" target="_blank">dojo</a>. Me sorprendió mucho lo fácil que nos resultó en comparación con todo lo que yo pensaba que iba a hacer falta.

Pese a que el jueves fue el día que menos programamos fue muy, muy constructivo. Me di cuenta de lo enriquecedor que resulta el intercambio de experiencias con gente de otras empresas. Y no hablo ya de otras culturas. Además las conversaciones con Xavi me hicieron reflexionar un montón y me llenaron de energía para afrontar lo que toque en los próximos meses.



## Quinto y último día

Después de los problemas de intendencia del jueves las cosas volvieron a la normalidad. Aprovechamos la mañana para programar a saco. Nos quedaba una tarea de las que detectamos el martes y tres tareas emergentes más que añadimos.

Para finiquitar la tarea que teníamos pendiente hice _paring_ con Xavi. No era algo excesivamente complicado y enseguida habíamos terminado la tarea y subido los cambios al SVN.

A partir de ese punto nos separamos. Xavi se centró en hacer los CSSs de la funcionalidad que estábamos terminando. Yo me quedé con las otras dos tareas emergentes. La primera de ellas consistía en dar soporte a los CSS haciendo que el componente _schedule_ que habíamos desarrollado en los días anteriores tuviera una serie de clases de estilo. La otra era dotarle de unas características por defecto: títulos, estructura, etc...

Me sorprendió la soltura que había conseguido en tan poco tiempo. Fui perfectamente capaz de completar las tareas por mi mismo, consultando a Xavi únicamente para que aprobara alguna de las decisiones de diseño que tomé. También tuve la oportunidad de refactorizar alguna de las especificaciones de <a href="http://pivotal.github.com/jasmine/" target="_blank">Jasmine</a> utilizando los <span class="code">describe</span> anidados que, hasta ese momento, nos eran inéditos.

Lo que más increíble me resultó fue la dependencia del _pairing_ que había desarrollado en tan poco tiempo. Me resultaba un poco raro programar solo. De hecho, cometí varios errores que con alguien al lado hubieran estado resueltos inmediatamente y que, sin embargo, tardé minutos en resolver. El que diga que el _pair programming_ es improductivo es porque realmente no lo ha probado. Y eso sin contar con que es mucho más divertido.

Justo antes de irnos a comer acabamos la historia de usuario e hicimos sonar la campana del éxito :D. (En Be Code hacen sonar una camapana cada vez que completan una historia de usuario).

Después de una apacible comida al sol en la <a href="http://maps.google.es/maps?f=q&source=s_q&hl=es&geocode=&q=plaza+de+la+virgen,+valencia&sll=40.396764,-3.713379&sspn=8.681468,19.753418&ie=UTF8&hq=&hnear=Plaza+de+la+Virgen,+Valencia,+Comunidad+Valenciana&ll=39.476067,-0.375515&spn=0.002149,0.004823&t=h&z=18" target="_blank">plaza de la virgen</a> disfrutando la comida uruguaya del Tentempié (fantástica comida para llevar) regresamos a las oficinas de Be Code. Allí nos esperaba Wolfram que había venido para resarcirse del viaje al siglo pasado del jueves y disfrutar con nostoros del _coding dojo_.

La tarde fue bastante poco productiva. Aproveché para despedirme de la gente de Be Code, agradecerles su hospitalidad y charlar un rato. Poco después pusimos rumbo al _coding dojo_ organizado por Openfinance.

Allí nos juntamos con <a href="http://twitter.com/#!/hell03610" target="_blank">Emma</a> (me resisto a llamarla por su nick en twitter :P) y volví a coincidir con <a href="http://www.twitter.com/#!/borillo" target="_blank">@borillo</a>. También pude desvirtualizar por fin a <a href="http://www.twitter.com/#!/elmendalerenda" target="_blank">@elmendalerenda</a> aka Miguel Ángel.

En el _coding dojo_ hicimos la kata del mes de <a href="http://www.12meses12katas.com" "_blank">12 meses 12 katas</a>: los números romanos. Hicimos dos pomodoros de 45 minutos sin cambio de parejas entre ellos. Una vez que los terminamos estuvimos poniendo en común las soluciones por las que habíamos optado cada uno.

Me sorprendió bastante la cantidad de gente que acudió al evento. Eramos tantos que apenas cupimos en las oficinas de Openfinance. Tanto es así que el próximo lo van a organizar en un lugar de mayores dimensiones para estar más cómodos y que pueda acudir aún más gente.

Con el _coding dojo_ puse final a mi semana en Valencia en lo relacionado con la programación. Aún me quedaban unas cuantas cervezas por delante y algo de turisteo por la ciudad con mi anfitrión <a href="http://twitter.com/#!/xav1uzz" target="_blank">@Xav1Uzz</a> antes de volver a Madrid.


## Prólogo y epílogo de mi semana en BeCode

Supongo que muchos ya sabíais que me proponía pasar una semana en Valencia con la gente de Be Code. A otros igual os pilló un poco de sorpresa saber que estaba allí. Como no he dado ninguna explicación de qué me llevó allí ni lo que pretendía con semejante experiencia quiero aprovechar esta retrospectiva para compartir los motivos que me llevaron a embarcarme en esta experiencia.

La primera vez que yo supe de que Be Code se ofrecía para recibir a extraños en sus oficinas fue <a href="http://www.becodemyfriend.com/2010/09/el-programador-errante/" target="_blank">en su blog</a>. Así me enteré de que <a href="http://twitter.com/#!/alejandropgarci" target="_blank">Alex</a> había pasado una semana allí y pude leer sobre <a href="http://www.adictosaltrabajo.com/tutoriales/tutoriales.php?pagina=redescubriendoAgilismo" target="_blank">su experiencia</a> y me dio bastante envidia :P. Me apetecía poder vivir en mis carnes la experiencia de desarrollar software de forma ágil con gente que realmente supiera hacerlo.

Durante el AOS escuché a <a href="http://twitter.com/#!/xav1uzz" target="_blank">Xavi</a> hablar de nuestras responsabilidad es como desarrolladores y a <a href="http://twitter.com/#!/kinisoftware" target="_blank">Kini</a> contar cuanto le impresionaron los valores de la gente de KFB cuando estuvo en Valencia. Ya he comentado alguna vez lo mucho que me impactó escuchar todo esto.

Durante la charla sobre <a href="http://en.wikipedia.org/wiki/Software_craftsmanship" target="_blank">Software Craftsmanship</a> se trató el tema de la comunidad de profesionales. Pude escuchar como este tipo de empresas como Eden o Be Code tienen las puertas abiertas a todo aquel profesional que quiera acudir y ver como funcionan. Así que me marqué como objetivo a medio plazo ir a alguna de ellas. De hecho formaba parte de los objetivos que me marqué para 2011.

Durante el Dev Open de Madrid tuve la oportunidad de hablar con Xavi que me dijo que tenía las puertas de Be Code abiertas. Desde ese momento ya era todo cuestión de tiempo. Tan pronto como pude disponer de tiempo programé el viaje.

El resultado lo habéis podido seguir en las anteriores entradas que he escrito.

Ahora, varios días después de regresar de esta pequeña aventura, puedo decir que ha sido una experiencia increíble y que espero poder repetirla.
