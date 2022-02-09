package org.eeit131.group5.controller;

import java.util.List;

import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.RewardPoints;
import org.eeit131.group5.service.HealthCenterService;
import org.eeit131.group5.service.RewardPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RewardPointsController {
	@Autowired
	RewardPointsService rewardPointsService;
	@Autowired
	HealthCenterService healthCenterService;
	
	@GetMapping("/consultion/rewardPointsFindbyMb/{mbid}")
	public @ResponseBody RewardPoints rewardPointsFindbyMb(
			@PathVariable Integer mbid ){
		
		RewardPoints rewardPoints= rewardPointsService.rpFindById(mbid);
		RewardPoints resultPoints=null;
		if(rewardPoints!=null) {
			List<HealthCenter> healthCenter=healthCenterService.findByMemberId(String.valueOf(mbid));
			if(healthCenter.size()>0) {
				HealthCenter lastdata=healthCenter.get(healthCenter.size()-1);
				Integer checkform=lastdata.getCheckform();
				if(checkform!=0&&checkform%10==0) {
					rewardPoints.setPoints(rewardPoints.getPoints()+5);
					rewardPointsService.update(rewardPoints);
					for(int i=0;i<healthCenter.size();i++) {
						HealthCenter updatedData=healthCenter.get(i);
						updatedData.setCheckform(0);
						healthCenterService.updateCheckform(updatedData);
					}
				}
				
			}
			
			resultPoints=rewardPoints;
		}else {
			RewardPoints rwPoints= new RewardPoints();
	    	rwPoints.setMemberId(mbid);
	    	rwPoints.setPoints(10);
	    	rewardPointsService.save(rwPoints);
	    	resultPoints=rewardPointsService.rpFindById(mbid);
		}
		return resultPoints;
	}
}
