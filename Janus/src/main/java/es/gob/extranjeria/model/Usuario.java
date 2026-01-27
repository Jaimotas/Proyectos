package es.gob.extranjeria.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "lga_usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id_usuario;
    
    @Column(unique = true)
    private String username;

    private String password;

	public long getId_usuario() { return id_usuario;	}
	public String getUsername() { return username;	}
	public String getPassword() {	return password;	}
}