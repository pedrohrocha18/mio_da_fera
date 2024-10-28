{% if settings.welcome_message or settings.welcome_text %}
	<section class="section-welcome-home" data-store="home-welcome-message">
		<div class="container">
			<div class="row text-center justify-content-center">
				<div class="col-md-8">
					<h2 class="js-institutional-message-text mb-4{% if settings.institutional_italic %} font-italic{% endif %}" {% if not settings.institutional_text %}style="display: none"{% endif %}>{{ settings.institutional_text }}</h2>
					<p class="js-welcome-message-title mb-3">
						<strong>Bem-vindo ao nosso DOCE LAR!</strong><br/><br/>
						Somos uma família de doceiros apaixonados, e a nossa história começou em 1998, em Uberlândia, Minas Gerais. Tudo teve início quando Vandimar e Rosicler, guiados pelo amor e pela paixão pelos doces,
						decidiram transformar essa alegria em um sustento para a sua família.
					 	O que era um sonho se tornou uma realidade, e desde então, temos encantado paladares e aquecido corações.<br/><br/>
						Nosso compromisso com a qualidade é inabalável. A cada ano, inovamos e expandimos nosso portfólio, de apenas seis opções de doces no início, chegamos a quase 20 delícias diferentes!
						Cada receita é cuidadosamente elaborada, utilizando ingredientes especiais e selecionados, porque acreditamos que cada detalhe faz a diferença.
						E, claro, o principal ingrediente que permeia todas as nossas criações é o amor. É o amor que colocamos em cada doce que fazemos, o mesmo amor que nos une como família e nos motiva a levar alegria até você.<br/><br/>
						A dedicação e o carinho que colocamos em nosso trabalho não são apenas para produzir iguarias; são para criar momentos inesquecíveis na vida de nossos clientes. 
						Cada doce que chega à sua casa é um pedaço do nosso coração e uma forma de espalhar felicidade. Queremos que cada mordida seja uma experiência única, repleta de sabor e nostalgia.<br/><br/>
						Agradecemos pela confiança e pelo apoio de todos que, ao longo dos anos, fizeram parte da nossa história. Estamos ansiosos para continuar essa deliciosa jornada ao seu lado, proporcionando momentos de alegria em forma de doces.
						 Sinta-se à vontade para explorar nossas deliciosas opções e descubra o que há de mais doce em nossa família!
					</p>
					<a href="{{ settings.welcome_link }}" class="js-welcome-message-button btn-link" data-has-url="{{ settings.welcome_link ? 'true' : 'false' }}" {% if not (settings.welcome_button and settings.welcome_link) %}style="display: none"{% endif %}>{{ settings.welcome_button }}</a>
				</div>
			</div>
		</div>
	</section>
{% endif %}


{#Código original#}
{#<p class="js-institutional-message-title mb-3" {% if not settings.institutional_message %}style="display: none"{% endif %}>{{ settings.institutional_message }}</p>#}
{#<h2 class="js-institutional-message-text mb-4{% if settings.institutional_italic %} font-italic{% endif %}" {% if not settings.institutional_text %}style="display: none"{% endif %}>{{ settings.institutional_text }}</h2>#}