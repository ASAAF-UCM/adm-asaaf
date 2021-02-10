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

Estas instrucciones resumen lo que es necesario para desplegar la aplicación, así como para testearla.


### Prerrequisitos

Debido a que la aplicación se sirve desde un contenedor de Docker, es completamente necesario tener instalado lo siguiente:
 * Docker Engine
 * Docker Compose
 * Docker Registry
 * Un servidor web, como nginx

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

Para realizar los tests se utiliza rspec.

### Despliegue

El despliegue del código sucede cuando se hace un merge en master. El procedimiento es el siguiente:

 1. Crea una rama
 2. Implementa las funciones deseadas en esa rama
 3. Haz un push con la rama.
 4. Haz un pull request para hacer un merge de tu rama con master.

Tras esto, correrán las pruebas y, si todo sale bien, se mergearán las ramas y se actualizará automáticamente la web.

## Hecho con

* [Rails](https://rubyonrails.org/)
* Amor


## Autores

* **Ismael Aderdor** - *Trabajo inicial* - [PurpleBooth](https://github.com/iaderdor)

## License

This project is licensed under the MIT License - see the [LICENCE.md](LICENCE.md) file for details

## Agradecimientos
