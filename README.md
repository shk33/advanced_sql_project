#Cadena de Favores (Miguel Coronel)
```
m.coronel.seg@gmail.com
```
====================
# Temas aplicados
##Uso de: Create Table , tipos de datos e índices
### Ejemplo: Creación de Tabla de Offers
``` sql
CREATE TABLE IF NOT EXISTS offers (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  service_request_id int(11) DEFAULT NULL,
  accepted tinyint(1) DEFAULT '0',
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id),
  KEY index_offers_on_service_request_id (service_request_id) USING BTREE,
  KEY index_offers_on_user_id (user_id) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1259 ;
```

##Uso de: Insert y Transactions
### Ejemplo: Seguir a un usuario (Crear un relationship)
``` sql
BEGIN
  INSERT INTO relationships (created_at, followed_id, follower_id, updated_at) VALUES ('2015-12-10 05:47:01', 2, 1, '2015-12-10 05:47:01')
COMMIT
``` 
##Uso de: UPDATE y SET
### Ejemplo: Actualizar el perfil de un usuario
``` sql
UPDATE users SET name = 'Super Admin', updated_at = '2015-12-10 05:53:12' WHERE users.id = 1
```

##Uso de: Delete
### Ejemplo: Dejar de seguir a un usuario (Eliminar un relationship)
``` sql
  DELETE FROM relationships WHERE relationships.id = 89
```

##Uso de: Select, Joins, Group By, Order By, Limit, Offset
### Ejemplo: Búsqueda de Service Request con services a través del título del servicio limitando a sólo 5 resultado para propósito de paginación de resultados
``` sql
SELECT  service_requests.* FROM service_requests 
  INNER JOIN services 
  ON services.service_request_id = service_requests.id 
  WHERE (LOWER(title) like '%test%' ) 
  GROUP BY service_requests.id  
  ORDER BY created_at DESC 
  LIMIT 5 
  OFFSET 0
```

## Uso de IN y Múltiples JOINS
### Ejemplo: Búsqueda de Service Request con services a través de etiquetas (Tags)
``` sql
SELECT service_requests.* 
  FROM service_requests 
  INNER JOIN services 
  ON services.service_request_id = service_requests.id 
  INNER JOIN services_tags 
  ON services_tags.service_id = services.id 
  INNER JOIN tags ON tags.id = services_tags.tag_id 
  WHERE tags.id 
  IN (1, 2) 
  GROUP BY service_requests.id 
  ORDER BY created_at DESC 
  LIMIT 5 
  OFFSET 0
```
## Uso de Agregate Functions
### Ejemplo: Contar número de usuarios favoritos
``` sql
  SELECT COUNT(*) FROM users 
  INNER JOIN relationships 
  ON users.id = relationships.follower_id 
  WHERE relationships.followed_id = 2
```

## Uso de custom functions
### Ejemplo: Obtener el estado del service Arrangement de manera legible
``` sql
DROP function IF EXISTS humanize_arrangement_status;
DELIMITER //
CREATE FUNCTION humanize_arrangement_status(status TINYINT)
  returns varchar(20)
  BEGIN
    DECLARE human_status varchar(20);
    if status = 0 then
      set human_status= "Incompleto";
    else
      set human_status="Completado";
    end if;

    return(human_status);
  end;
//
DELIMITER ;
```
* Uso
``` sql
SELECT  humanize_arrangement_status(completed) AS status 
    FROM service_arrangements 
    WHERE service_arrangements.id = 15 
    LIMIT 1;
```
##Vistas
### Ejemplo: Obtener los últimos 3 requests
``` sql
CREATE OR REPLACE VIEW latest_requests AS
  SELECT  service_requests.* 
  FROM service_requests 
  ORDER BY created_at DESC LIMIT 3;
```

* Uso
``` sql
SELECT * FROM latest_requests;
```


# Instalación de Ruby/Rails
* Instalar algunas dependencias
```
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
```

* Instalar Ruby usando rbenv

```
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.3
rbenv global 2.2.3
ruby -v
```
* Instalar la Gema Bundle

```
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
```

* Instalando dependencias de Rails (Node.js)
```
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
```

* Instalando Rails
```
gem install rails -v 4.2.4
```

* Haciendo Rails ejutable
```
rbenv rehash
```

* Verificando que Rails funcione
```
rails -v
# Rails 4.2.4
```

# Instalación de la Aplicación WEB

* Poner el código en una carpeta

* Moverse a la carpeta del proyecto
<tt>cd cadena-favores</tt>.

* Ejecutar el comando 
<tt>bundle install</tt>.

* Abrir el archivo <tt>config/application.example.yml</tt>.
```
DATABASE_NAME: "cadena_favores"
DATABASE_USERNAME: "root"
DATABASE_PASSWORD: "password"
DATABASE_HOST: "127.0.0.1"
```

* Modifcar los valores DATABASE_USERNAME y DATABASE_PASSWORD con la configuración de su computadora de MySql.

* Duplicar el archivo <tt>config/application.example.yml</tt> y al archivo duplicado renombrarlo como <tt>config/application.yml</tt>


* Ejecutar el comando
<tt>rake db:setup</tt>

* Ejecutar el comando
<tt>rails server</tt>.

* Visitar la página en locahost:3000

# Nota
Correr todos los comandos genera automáticamente la base de datos.
En caso de no lograr ejecutar los comandos el backup se encuentra en el archivo: <tt>cadena_favores_development.sql</tt>