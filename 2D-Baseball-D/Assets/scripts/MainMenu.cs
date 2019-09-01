using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
	public void PlayGame(){
		
		// + 1 goes to next scene in the "queue"
		SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
	}
	
	public void QuitGame(){
		Debug.Log("QUIT!");
		Application.Quit();
	}
}
