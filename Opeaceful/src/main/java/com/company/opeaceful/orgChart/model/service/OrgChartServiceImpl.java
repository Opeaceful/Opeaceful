package com.company.opeaceful.orgChart.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.orgChart.model.dao.OrgChartDao;

@Service
public class OrgChartServiceImpl implements OrgChartService {

	@Autowired
	private OrgChartDao orgChartDao;
}
