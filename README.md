# Web administrativa de ASAAF

Este repositorio contiene la web administrativa de ASAAF. Actualmente, esta web realiza las siguientes funciones:
 * Ninguna porque está en desarrollo

En el futuro, la intención es añadir las siguientes funciones:

 * Inscripción de nuevos socios
 * Gestión de los socios
 * Inventario de materiales
 * Préstamo de materiales
 * Ayuda a las tareas burocráticas

## Comenzando

Estas instrucciones incluyen cómo construir la imagen para servir la web desde
un contenedor usando docker-compose.

### Prerrequisitos

Para poder generar la imagen, se necesita disponer de una variable de entorno
llamada `RAILS_MASTER_KEY`. Es necesaria porque en el ensamblado del contenedor,
webpacker la utiliza, ya que necesita acceder a la `secret_key_base`, que se
encuentra almacenada en `config/credentials/production.yml.enc`.

Esto quiere decir que con anterioridad, necesitamos generar una clave, que puede
generarse usando el siguiente comando:

```bash
bundle exec rails secret
```

Lo que nos devuelva ese comando deberemos guardarlo y a continuación guardarlo
encriptado para el entorno de producción, lo cual se hace con el siguiente
comando:

```bash
bundle exec rails credentials:edit --environment production
```

El fichero a editar sigue el formato yml. Bastará con añadir lo siguiente:

```yml
secret_key_base: <Cadena que hayamos copiado>
```

Una vez hecho esto, pasamos a generar la imagen:

```bash
docker build -t adm_asaaf .
```

Una vez generada la imagen correspondiente, tendremos que crear un archivo
`db-passwd.env`, que guarda la variable de entorno que se usa para asignar la
contraseña de la basea de datos. Finalmente, ejecutamos el siguiente comando:

```bash
docker-compose up -d
```

Con esto, tendremos disponible la aplicación a través del puerto 3000 de la
máquina donde lo hayamos desplegado.

### Instalación

La instalación a realizar consiste en generar la base de datos con sus tablas
correspondientes y poblarlas. En primer lugar, accedemos al contenedor de la
web. Para ello, ejecutamos en la carpeta donde esté el `docker-compose.yml` que
hayamos usado el comando:

```bash
docker-compose dcr bash
```

Una vez dentro del contenedor, ejecutamos los dos siguientes comandos:

```bash
bundle exec rails db:migrate
bundle exec rails db:seed
```

### Documentación

Para generar la documentación, hay que lanzar el siguiente comando en la base
del repo:

```
  yard
```

Tras esto, abrimos con un navegador web `doc/index.html`.

### Tests

Para realizar los tests se utiliza rspec. Para comprobar que todo funciona
correctamente, ejecutamos el siguiente comando:

```bash
bundle exec rspec
```

### Despliegue

Cada vez que se hace un merge a master, se crea una imagen de docker que se
almacena en el ECR.

*Se completará conforme se vayan realizando los distintos pasos* 

## Hecho con

* [Rails](https://rubyonrails.org/)
* Amor


## Autores

* **Ismael Aderdor** - *Trabajo inicial* - [iaderdor](https://github.com/iaderdor)

## License

Este proyecto está licenciado a través de la licencia MTI - el archivo
[LICENCE.md](LICENCE.md) contiene más detalles al respecto.

## Agradecimientos
