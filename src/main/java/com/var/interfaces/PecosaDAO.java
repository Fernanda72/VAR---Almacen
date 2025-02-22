package com.var.interfaces;

import java.util.List;

import com.var.dto.PecosaDTO;
import com.var.entidad.Pecosa;

public interface PecosaDAO {
	public String codigoCorrelativo();
	public List<PecosaDTO> listAll();
	boolean registrar(Pecosa pecosa);
}
