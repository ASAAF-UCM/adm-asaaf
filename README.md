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

### Instalación

A continuación se muestran los distintos pasos necesarios para instalar la aplicación.

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

## Hecho con

* [Rails](https://rubyonrails.org/)
* Amor


## Autores

* **Ismael Aderdor** - *Trabajo inicial* - [iaderdor](https://github.com/iaderdor)

## License

This project is licensed under the MIT License - see the [LICENCE.md](LICENCE.md) file for details

## Agradecimientos
