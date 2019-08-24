using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class MainMenu : MonoBehaviour
{
    public void MainMenuScene()
    {
        SceneManager.LoadScene(0);
    }
    public void PlayGame ()
    {
        SceneManager.LoadScene("GamePrep");
    }
    public void PlayStart()
    {
        SceneManager.LoadScene("Play_Start");
    }
    public void QuitGame()
    {
        Debug.Log("Quit!");
        Application.Quit();
    }
}
